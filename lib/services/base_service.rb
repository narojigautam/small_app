require 'faraday'
require 'uri'
require 'net/http'
require 'json'
class BaseService

	def initialize
		@connection = Faraday.new(:url => 'http://api-impac-uat.maestrano.io') do |faraday|
		    faraday.request  :url_encoded
		    faraday.response :logger
		    faraday.use Faraday::Request::BasicAuthentication, '72db99d0-05dc-0133-cefe-22000a93862b', '_cIOpimIoDi3RIviWteOTA'
		    faraday.adapter  Faraday.default_adapter
		end
	end

	def get(endpoint, options = {})
		response = @connection.get(endpoint, options).body
		JSON.parse(response)
	end
end
