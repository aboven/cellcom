require 'net/http'
require 'uri'

module Cellcom
  class Request
    API_URL = 'http://www.cellcom.be/data/bulkHTTP.php'

    def initialize(params={})
      @params = params
    end

    def get(opts={})
      connection(opts).start { |conn| conn.request(Net::HTTP::Get.new(uri)) }
    end

    def connection(opts={})
      Net::HTTP.new(uri.host, uri.port).tap do |http|
        http.open_timeout = http.read_timeout = opts[:timeout] if opts.key? :timeout
      end
    end

    def uri
      URI(API_URL).tap do |uri|
        uri.query = URI.encode_www_form(@params)
      end
    end
  end
end
