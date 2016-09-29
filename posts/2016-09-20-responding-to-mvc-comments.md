---
title: "Responding to MVC comments from the DZone Java EE survey"
author: "Christian Kaltepoth"
layout: post
tags: [ mvc, javaee, javaone ]
---

Back in early 2014 Oracle released the results of the Java EE community survey
which was created to gather feedback about what developers want to see
Java EE 8. One of the questions in the survey was whether people would like to see
a MVC web framework alongside with JSF in Java EE 8.
[The result](https://java.net/downloads/javaee-spec/JavaEE8_Community_Survey_Results.pdf)
was clear. Over 60% of the participates voted "Yes". As a result
[JSR 371 (MVC 1.0)](https://jcp.org/en/jsr/detail?id=371) was started
to work on the new action-based web framwork for Java EE.

Fast forward to 2016. JSR 371 has been doing well. The EG released the
second early draft review and got a lot of positive feedback. The JSR was moving
forward even after Oracle suddenly stopped all work on the Java EE JSRs.
A strong indicator that MVC is relevant and highly required by the Java
community.

Last week Oracle announced the revised plan for Java EE 8 during JavaOne 2016.
Surprisingly they now question whether an action-based MVC web-framwork is
still relevant in the cloud age and therefore proposed to drop MVC 1.0.
At the same time Oracle just started a [new survey](https://glassfish.java.net/survey/)
to get feedback about the revised plan for Java EE 8. This survey contains the
following statement:

> When we first proposed Java EE 8, we got feedback that an action based web
> UI MVC framework standard would be a good addition to Java EE.
> We're now questioning whether it is still important to complete the
> MVC API (JSR 371).

I don't understand how Oracle comes to the conclusion that MVC is not relevant
any more. People wanted it in 2014 and the EG is getting great feedback
for the work done so far. So what changed in the last two years?

I was wondering what people really think about JSR-371 (MVC 1.0) in 2016.
So I had a look of the survey results of the DZone Java EE survey which
was created with the help of the
[Java EE guardians](https://javaee-guardians.io/). I checked all the comments
referring to MVC, especially from people which considered MVC as "not important".
Then I created a list of representative comments and wrote down my thoughts about
them:

**Comment: Modern web applications use stateless REST services anyway.**

It's true, that JavaScript based web frameworks like AngularJS, React, vue.js
and friends are very popular today. Writing single page applications (SPAs)
which run completely in the browser and get their data from REST backend
services has many advantages, especially in regard to usability and scalability.

However, if you have been long enough in the IT industry, you have hopefully
learned that there is no silver bullet. Never. Developers created various
web application frameworks for decades. And guess what, nobody ever created
a framework which solves all your problems. That's why there are so many of
them. There is no "right" and "wrong" approach for web frameworks. There are
different categories which address different problem domains. You have to
choose the right tool for your specific requirements.
If your application is not highly interactive and if you have to deal with
SEO requirements, a server-rendered web framework may be your best choice.

Searching for silver bullets seems to be a common phenomenon in our
industry. Some people for example seem to think that NoSQL databases like
MongoDB, Redis, Cassandra and others are the silver bullet for storing data.
No, they aren't. There are many use cases for which MongoDB is a great fit,
but depending on your specific requirements a classic relational database
may still work better. The answer is simply: it depends!

So I think it totally makes sense to provide an alternative web framework
in Java EE which implements a completely different concept than JSF. Neither
of the two frameworks is right or wrong. They are different. So you can
use Angular + JAX-RS, classic JSF or the new MVC framework depending
on your needs. Having a choice is a good thing.

**Comment: The same can be achieved with JAX-RS**

That's true. JAX-RS is a great foundation for creating web applications. That's
why MVC is based on JAX-RS. Actually MVC is just a very thin layer on top of
JAX-RS which provides everything you need to build a server-rendered web
application with JAX-RS. So MVC doesn't reinvent the wheel but builds on top of
what the Java EE platform already provides. You should have a look at the latest
API. I'm sure you will be surprised how easy it is to create a web application
with MVC 1.0 compared to do it manually with plain JAX-RS.

**Comment: If a new framework is added, completely remove JSF before,
or it will be to complicated for a new user to choose.**

Well, dropping JSF would be a REALLY bad idea. Backward compatibility is a key
feature of the Java EE platform. If you invested in JSF by building
applications using it, your investment will be safe. Future versions of the
platform will keep supporting JSF for the foreseeable future. And that's great,
unless you boss allows you to migrate your application to a new web framework
every few months. But I guess that's not the case. ;-)

If MVC 1.0 gets included in Java EE 8, you will have the choice between
two web frameworks. And that's great. Ed Burns wrote a
[great blog post](http://www.oracle.com/technetwork/articles/java/mvc-2280472.html)
about this topic. I highly recommend to read his post. The key message
is that component oriented and action based web frameworks are completely
different concepts and both have their right to exist. Why? Remember, there
is no silver bullet. You should use the framework which best fits your needs.
The same is true for other technologies. If you want to process XML, you can
either use low level APIs like DOM/SAX/StAX or you could use a mapper like
JAXB. Which one to choose depends on your specific needs.

**Comment: I think it missed the train and now comes too late.**

Well, in my view a JSR like MVC 1.0 should always try to standardize things
that are proven to work good in practice. Therefore creating a JSR to standarize
well established concepts can never be too late.

JPA is a very good example for this. Prior to EJB 3.0, persistence in Java EE
was a very heavy weight approach which produced a lot of overhead. Most
developers weren't happy with it. That's why people preferred 3rd party
solutions like Hibernate. So Hibernate became a de-facto standard for ORM in Java.
The JPA specification then created a standard which was heavily influenced by
Hibernate. Which is a good thing. Remember that standardization should focus
on technology that is battle tested and works good in practice. So did JPA
and that's why Hibernate and JPA a very similar.

The same should be done for MVC. Of cause there are many MVC frameworks out
there. And that's good because today we know which concepts work best.
The most popular MVC framework in the Java space is Spring MVC. That's
why MVC 1.0 is heavily influenced by Spring MVC. Some people criticize that
MVC 1.0 copies Spring MVC too much. But these people don't understand that
using concepts from well established frameworks for standardization is a good
thing.

**Comment: Happy with Spring MVC :-)**

Hey, you are using Spring MVC? That's great! Spring MVC is awesome! If you
are happy with it, there is almost no good reason to migrate your apps to MVC 1.0.
However, if you are creating a new application with there Java EE platform,
using MVC 1.0 which ships with your container may be an interesting option. Especially
if you are using Java EE technologies like CDI, JAX-RS, Bean Validation and
friends. In this case including Spring into your project just to get the
web framework part is not required any more. But if you are typically using
the Spring framework and many other components of the Spring ecosystem,
you should definitely go with Spring MVC.

**Comment: Too late. Enhance JAX-RS.**

Back then, before JSR 371 (MVC 1.0) was started, there were quite some
discussion whether MVC web framework support should be added to JAX-RS or
if a separate specification would make more sense. At that time the
JAX-RS EG decided that adding web framework related concepts to the core
JAX-RS API would not be a good idea. So a separate JSR was created. However,
as I mentioned before, MVC 1.0 is based on JAX-RS. So I could argue
that MVC 1.0 is actually an enhancement of the JAX-RS spec. It's just a
separate specification bundled in a separate JAR which is using a different
package name.

**Final words**

Thanks for reading so far. I hope you liked reading my thoughts about
MVC 1.0 and Oracle's decision to drop it from Java EE 8. If you agree with me
that MVC is still relevant and should be included in Java EE 8, please fill out
the [new Oracle Java EE survey](https://glassfish.java.net/survey/) and
help to confess Oracle to keep investing in MVC 1.0.
