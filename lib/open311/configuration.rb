require 'faraday'
require File.expand_path('../version', __FILE__)

module Open311
  module Configuration
    VALID_OPTIONS_KEYS   = [:adapter, :api_key, :endpoint, :format, :jurisdiction, :proxy, :user_agent].freeze
    VALID_FORMATS        = [:json, :xml].freeze

    DEFAULT_ADAPTER      = Faraday.default_adapter.freeze
    DEFAULT_API_KEY      = nil.freeze
    DEFAULT_ENDPOINT     = nil.freeze
    DEFAULT_FORMAT       = :json.freeze
    DEFAULT_JURISDICTION = nil.freeze
    DEFAULT_PROXY        = nil.freeze
    DEFAULT_USER_AGENT   = "Open311 Ruby Gem #{Open311::VERSION}".freeze

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def reset
      self.adapter      = DEFAULT_ADAPTER
      self.api_key      = DEFAULT_API_KEY
      self.endpoint     = DEFAULT_ENDPOINT
      self.format       = DEFAULT_FORMAT
      self.jurisdiction = DEFAULT_JURISDICTION
      self.proxy        = DEFAULT_PROXY
      self.user_agent   = DEFAULT_USER_AGENT
    end
  end
end
