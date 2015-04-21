---
title: "View technologies for MVC 1.0"
author: "Christian Kaltepoth"
layout: post
tags: [ mvc, javaee ]
---

The [MVC 1.0 (JSR371)](https://jcp.org/en/jsr/detail?id=371) specification has just
released an [early draft](https://jcp.org/aboutJava/communityprocess/edr/jsr371/index.html)
for review. I'm very happy to see that people are interested in this JSR and start
to have a deeper look at how MVC 1.0 will look like. At this point any kind of feedback
is very valuable and welcome.

One of the questions which is asked very frequently is which view technologies MVC 1.0
will support. The answer is that MVC has built-in support for
[JSP](http://docs.oracle.com/javaee/5/tutorial/doc/bnagx.html) and [Facelets](http://docs.oracle.com/javaee/6/tutorial/doc/giepx.html).
This seems to disappoint people. Especially because JSP
isn't considered to be a "modern" view technology any more.

I want to note a few things here. First JSP isn't as bad as most people think. Sure,
it has its weaknesses (like any other technology), but there are good arguments for using
JSP. Every IDE for example supports JSP out of the box and I think
that decent tooling is something that is lacking for many of the other view technologies.
One of the major problems with JSP is that it allows you to do really really bad things
like embedding Java code in the view. But if you use JSP in a reasonable way, it works
very well. And if you don't like JSP, you can also choose Facelets which has been around
in the JSF world for quite some time and offers many great templating concepts.

However, I agree that there are many other great view technologies out there. And
I fully understand people who prefer libraries like [Thymeleaf](http://www.thymeleaf.org/)
as they offer many great features you don't get with JSP or Facelets.

One of the things I like most about MVC 1.0 is that it actually doesn't matter what
view technologies it supports out of the box. Why? Because it is so easy
to integrate arbitrary view technologies with MVC. You don't believe me? Ok, here is
an example to convince you.

# Creating a custom view engine

One of the most popular template engines for [node.js](https://nodejs.org/)
is [Jade](http://jade-lang.com/). Similar to [Haml](http://haml.info/) in
the Ruby world it is based on the idea to use indention to define blocks which basically
means that you don't need to manually close elements any more. There is even a Java
implementation of the Jade language called
[jade4j](https://github.com/neuland/jade4j). So let's have a look the required steps
to use jade4j as the view technology for your MVC 1.0 based application.

To integrate a template engine with MVC, you have to implement the
[ViewEngine](https://ozark.java.net/javax.mvc-api-1.0-edr1-javadoc/javax/mvc/engine/ViewEngine.html)
interface which consists of only two methods. MVC 1.0 uses [CDI](http://cdi-spec.org/)
to discover all view engine implementations. There is no need to register the implementation
anywhere. Just add <code>@ApplicationScoped</code> to your implementation and MVC will find it.

OK, let's have a look at the code:

<pre class="java"><code>@ApplicationScoped
public class JadeViewEngine implements ViewEngine {

  @Inject
  private ServletContext servletContext;

  @Override
  public boolean supports(String view) {
    return view.endsWith(".jade");
  }

  @Override
  public void processView(ViewEngineContext context) throws ViewEngineException {

    try {

      String viewName = "/WEB-INF/views/" + context.getView();
      URL template = servletContext.getResource(viewName);

      String html = Jade4J.render(template, context.getModels(), true);

      context.getResponse().getWriter().write(html);

    } catch (IOException e) {
      throw new IllegalStateException(e);
    }

  }

}</code></pre>

That's all! Everything you need to integrate jade4j with MVC 1.0. That's not much code,
isn't? Of cause this code can be (and should be) improved in regard to error handling,
caching and so on. But it is a great example to demonstrate the basics.

The <code>supports()</code> method is used by the MVC implementation to find the view
engine responsible for the view name returned by a controller method or specified with
the <code>@View</code> annotation. In this example our view engine will process all
views with the file extension <code>.jade</code>.

The <code>processView()</code> method is where all the magic happens. The purpose
of this method is to render the view and write the result to the response stream.
Everything you need for this is available from the <code>ViewEngineContext</code>.
The code above uses the <code>ServletContext</code> to load the Jade template from
the default view folder <code>/WEB-INF/views</code>. Jade4J provides simple static methods
you can use to evaluate templates. All you need is the template and a model.
After that you can write the resulting HTML page to the output stream.

# Using the view engine

Now let's check if the view engine works as expected. First we will create a simple
controller that uses the [MVC 1.0 API](https://ozark.java.net/javax.mvc-api-1.0-edr1-javadoc/):

<pre class="java"><code>@Path("/hello")
public class HelloController {

  @Inject
  private Models models;

  @GET
  @Controller
  public String controller() {
    models.put("name", "Christian");
    return "hello.jade";
  }

}</code></pre>

As you see there is nothing special about this controller. It looks like every other
MVC 1.0 controller. The only difference is that it returns the view name
<code>hello.jade</code> instead of something like <code>hello.jsp</code>. Now let's have
a look at the corresponding view:

<pre class="nohighlight"><code>!!! 5
html
  head
    title Jade4J Demo
  body
    h1.
      Hello #{name}</code></pre>

I guess this looks very weird if you have never seen something like
[Jade](http://jade-lang.com/) or [Haml](http://haml.info/) before. This is a simple page
that renders a <code>h1</code> element containing a greeting. It uses EL-like expressions
to reference values from the model. If you want to learn more
about Jade, have a look at the [Jade Language Reference](http://jade-lang.com/reference/).

So you see the Jade integration is working fine. And we had to create just a single class.
Easy, isn't it? :)

# Conclusion

I hope this example shows you how easy it is to integrate custom view technologies with
MVC 1.0. [Ozark](https://ozark.java.net/), the reference implementation of MVC 1.0, already
provides a number of extra view engine implementations for template engines like
[Thymeleaf](http://www.thymeleaf.org/), [Freemarker](http://freemarker.org/),
[Velocity](http://velocity.apache.org/), [Handlebars](https://github.com/jknack/handlebars.java)
and [Mustache](https://github.com/spullara/mustache.java). All of them are available
from [Maven Central](http://search.maven.org/#search%7Cga%7C1%7Cg%3A%22com.oracle.ozark.ext%22).

I hope you enjoyed this blog post. If you want to give MVC 1.0 a try, I recommend to have a look at
[todo-mvc](https://github.com/chkal/todo-mvc), which is a small sample application I created to demonstrate
how a typical application created with MVC 1.0 looks like.

Have fun!
