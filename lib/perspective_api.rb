module PerspectiveAPI
  COMMENT_TYPES = {
    :plain_text => "PLAIN_TEXT",
    :html       => "HTML"
  }.freeze

  Error        = Class.new StandardError
  RequestError = Class.new PerspectiveAPI::Error

  def self.analyse_toxicity(text, type = nil, options = {})
    if type.is_a?(Hash)
      type, options = nil, type
    end

    PerspectiveAPI::AnalyseToxicity.call text, type, options
  end

  def self.toxicity_score(text, type = nil, options = {})
    analyse_toxicity(text, type, options).
      fetch("attributeScores").
      fetch("TOXICITY").
      fetch("summaryScore").
      fetch("value")
  end
end

require "perspective_api/analyse_toxicity"
require "perspective_api/options"
