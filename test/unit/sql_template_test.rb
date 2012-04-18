require 'test_helper'

class SqlTemplateTest < ActiveSupport::TestCase
  test "should return a template with the saved body" do
    resolver = SqlTemplate::Resolver.instance
    details  = { :formats => [:html], :locale => [:en], :handlers => [:erb]}

    # Resolver won't find any template as the db is empty
    assert resolver.find_all("index", "posts", false, details).empty?

    SqlTemplate.create!(
      :body    => "<%= 'Hi from SqlTemplate!' %>",
      :path    => "posts/index",
      :format  => "html",
      :locale  => "en",
      :handler => "erb",
      :partial => false
    )

    template = resolver.find_all("index", "posts", false, details).first
    assert_kind_of ActionView::Template, template
    
    assert_equal "<%= 'Hi from SqlTemplate!' %>", template.source
    assert_match /SqlTemplate - \d+ - "posts\/index"/, template.identifier
    assert_match /ActionView::Template::Handlers::ERB/, template.handler.to_s
    assert_equal [:html], template.formats
    assert_equal "posts/index", template.virtual_path
  end
  
  test "should expire cache on update" do
    cache_key = Object.new
    resolver  = SqlTemplate::Resolver.instance
    details   = { :formats => [:html], :locale => [:en], :handlers => [:erb] }

    t = resolver.find_all("index", "users", false, details, cache_key).first
    assert_match /Listing users/, t.source
    
    sql_template = sql_templates(:one)  #Get first template from fixtures (obscure syntax)
    sql_template.update_attributes(:body => "New body for template")

    t = resolver.find_all("index", "users", false, details, cache_key).first
    assert_equal "New body for template", t.source
  end
  
end
