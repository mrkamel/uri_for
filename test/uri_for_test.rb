
require File.expand_path("../../lib/uri_for", __FILE__)
require "test/unit"

class TestRequest
  attr_accessor :host, :port  

  def ssl?
    port == 443
  end
end

class TestController
  attr_accessor :request

  include UriForController
end

class TestView
  attr_accessor :controller

  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::AssetTagHelper
end

class TestModel
  include UriFor
end

class UriForTest < Test::Unit::TestCase
  def test_uri_for_model
    model = TestModel.new

    assert_equal "http://test.host/path/to/file", model.uri_for(:host => "test.host", :path => "/path/to/file")
    assert_equal "https://test.host/path/to/file", model.uri_for(:host => "test.host", :port => 443, :path => "/path/to/file")
  end

  def test_uri_for_mailer_view
    view = TestView.new

    assert_equal "http://test.host/path/to/file", view.uri_for(:host => "test.host", :path => "/path/to/file")
    assert_equal "https://test.host/path/to/file", view.uri_for(:host => "test.host", :port => 443, :path => "/path/to/file")
  end

  def test_uri_for_view
    view = TestView.new

    view.controller = TestController.new

    view.controller.request = TestRequest.new
    view.controller.request.host = "other.host"

    assert_equal "http://other.host/path/to/file", view.uri_for(:path => "/path/to/file")

    view.controller.request.port = 443

    assert_equal "https://other.host/path/to/file", view.uri_for(:path => "/path/to/file")
  end

  def test_uri_for_controller
    controller = TestController.new
    controller.request = TestRequest.new

    assert_equal "http://test.host/path/to/file", controller.uri_for(:host => "test.host", :path => "/path/to/file")

    controller.request.host = "other.host"

    assert_equal "http://other.host/path/to/file", controller.uri_for(:path => "/path/to/file")

    controller.request.port = 443

    assert_equal "https://other.host/path/to/file", controller.uri_for(:path => "/path/to/file")
  end
end

