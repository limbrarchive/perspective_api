class PerspectiveAPI::Options
  KNOWN_KEYS = %i[
    context_entries attributes languages do_not_store client_token session_id
    api_key
  ].freeze

  UnexpectedOptionsError = Class.new PerspectiveAPI::Error

  @mutex    = Mutex.new
  @defaults = {
    :attributes => {"TOXICITY" => {}}
  }.freeze

  def self.get
    @options
  end

  def self.set(options = {})
    @mutex.synchronize do
      @options = apply_to(@defaults, options).freeze
    end
  end

  def self.reset
    set
  end

  def self.apply(options = {})
    apply_to @options, options
  end

  def self.apply_to(original, options)
    results    = original.merge options
    unexpected = results.keys - KNOWN_KEYS

    if unexpected.empty?
      results
    else
      raise UnexpectedOptionsError,
        "Unexpected options #{unexpected.inspect}. " \
        "Known values are #{KNOWN_KEYS.inspect}"
    end
  end
end

# Set to defaults
PerspectiveAPI::Options.reset
