
require "uri_for/version"
require "action_controller"
require "active_record"
require "action_view"
require "uri"

module UriFor
  def uri_for(options = {})
    if options[:port] == 443
      URI::HTTPS.build(options).to_s
    else
      URI::HTTP.build(options).to_s
    end
  end
end

module ActionView
  module Helpers
    module UrlHelper
      include UriFor

      alias_method :default_uri_for, :uri_for

      def uri_for(options = {}) 
        @controller.uri_for options
      rescue
        default_uri_for options
      end 
    end 

    module AssetTagHelper
      def image_tag_for_uri(options = {}, image_tag_options = {}) 
        image_tag uri_for(options), image_tag_options
      end 
    end 
  end 
end

module ActiveRecord
  class Base
    include UriFor
  end 
end

module UriForController
  def uri_for(options = {}) 
    ops = (options || {}).dup

    ops[:host] ||= request.host
    ops[:port] ||= request.port

    if request.ssl?
      URI::HTTPS.build(ops).to_s
    else
      URI::HTTP.build(ops).to_s
    end
  end
end

module ActionController
  class Base
    include UriForController
  end
end

