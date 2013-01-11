Awestruct::Extensions::Pipeline.new do
  extension Awestruct::Extensions::Posts.new('/posts', 'posts')
  extension Awestruct::Extensions::Tagger.new( :posts, '/index', '/posts/tags', :per_page=>10 )
  extension Awestruct::Extensions::Atomizer.new( :posts, '/feed.atom', :feed_title=>'Christian Kaltepoth\'s Blog' )
  extension Awestruct::Extensions::Disqus.new()
  helper Awestruct::Extensions::GoogleAnalytics
end

