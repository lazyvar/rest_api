require "rest_api/version"
require "rest-client"

module RestApi
  class Error < StandardError; end

  class Base
    class << self
      def get(path, headers={}, &block)
        parse_response RestClient.get(build_url(path), headers.merge(base_headers), &block)
      end

      def post(path, payload, headers={}, &block)
        parse_response RestClient.post(build_url(path), payload, headers.merge(base_headers), &block)
      end

      def patch(path, payload, headers={}, &block)
        parse_response RestClient.patch(build_url(path), payload, headers.merge(base_headers), &block)
      end

      def put(path, payload, headers={}, &block)
        parse_response RestClient.put(build_url(path), payload, headers.merge(base_headers), &block)
      end

      def delete(path, headers={}, &block)
        parse_response RestClient.delete(build_url(path), headers.merge(base_headers), &block)
      end

      def head(path, headers={}, &block)
        parse_response RestClient.head(build_url(path), headers.merge(base_headers), &block)
      end

      def options(path, headers={}, &block)
        parse_response RestClient.options(build_url(path), headers.merge(base_headers), &block)
      end

      private

      def build_url(path)
        "#{const_get 'BASE_URL'}/#{path}"
      end

      def parse_response(response)
        RecursiveOpenStruct.new(JSON.parse(response))
      end

      def base_headers
        {}
      end
    end
  end
end
