require "uri"
require "net/http"
require "multi_json"

class PerspectiveAPI::AnalyseToxicity
  ANALYSE_URI = URI(
    "https://commentanalyzer.googleapis.com/v1alpha1/comments:analyze"
  ).freeze

  def self.call(text, type, options)
    new(text, type, options).call
  end

  def initialize(text, type, options)
    @text    = text || ""
    @type    = PerspectiveAPI::COMMENT_TYPES[type || :plain_text]
    @options = PerspectiveAPI::Options.apply(options || {})
  end

  def call
    if response.code == "200"
      MultiJson.load response.body
    else
      raise PerspectiveAPI::RequestError, response.body
    end
  end

  private

  attr_reader :text, :type, :options

  def request
    @request ||= begin
      request = Net::HTTP::Post.new uri
      request["Content-Type"] = "application/json"
      request.body = request_body
      request
    end
  end

  def request_body
    MultiJson.dump request_hash.select { |key, value| !value.nil? }
  end

  def request_hash
    {
      :comment             => {:text => text, :type => type},
      :context             => options[:context],
      :languages           => options[:languages],
      :requestedAttributes => options[:attributes],
      :doNotStore          => options[:do_not_store],
      :clientToken         => options[:client_token],
      :sessionId           => options[:session_id]
    }
  end

  def response
    @response ||= Net::HTTP.start(
      uri.host, uri.port, :use_ssl => true
    ) do |http|
      http.request(request)
    end
  end

  def uri
    @uri ||= begin
      uri       = ANALYSE_URI.dup
      uri.query = URI.encode_www_form(:key => options[:api_key])
      uri
    end
  end
end
