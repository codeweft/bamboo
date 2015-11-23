require 'json'

class Crawler
  attr_reader :status, :json
  def initialize status, json
    @status = status
    @json = JSON.parse(json)
  end

  def method_missing(key, *args)
    key = key.to_s
    if args.empty?
      json = @json
    else
      json = args[0]
    end
    if json.respond_to?(:key?) && @json.key?(key)
      json[key]
    elsif json.respond_to?(:each)
      r = nil
      json.find{ |*a| r= self.method_missing(key, a.last) }
      r
    end
  end
end
