require "bamboo/version"
require 'json'
require "net/http"

class Bamboo
  attr_reader :host, :port, :username, :password, :request_uri
  def initialize host, port, username, password, request_uri = '/rest/api'
    @host = host
    @port = port
    @username = username
    @password = password
    @request_uri = @request_uri.to_s + request_uri
  end

  def get
    @request_uri = @request_uri + '.json?os_authType=basic'
    puts "=====>Making Request<====="
    puts "HOST: #{@host}"
    puts "PORT: #{@port}"
    puts "URI : #{@request_uri}"
    http = Net::HTTP.new(host, port)
    request = Net::HTTP::Get.new(@request_uri)
    request.basic_auth(@username, @password)
    response = http.request(request)
    puts "=====>Request Status<====="
    puts "STATUS: #{response.code}"
    puts "BODY  : #{response.body}"
    return response.code, response.body.to_json
  end

  def method_missing(name, *args)
    request_uri = @request_uri+'/'+name.to_s
    request_uri = request_uri + '/' + args.join('/') unless args.empty?
    return Bamboo.new(@host, @port, @username, @password, request_uri)
  end
end
