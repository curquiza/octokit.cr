require "logger"
require "./default"

module Octokit
  # Provides configuration options for `Client`.
  module Configurable
    macro included
      # Access token for authentication.
      class_property access_token : String? = nil

      # Whether or not to automatically fetch the complete results from
      # paginated endpoints.
      class_property auto_paginate : Bool = Default.auto_paginate

      # Bearer token for authentication.
      class_property bearer_token : String? = nil

      # Client ID for authentication.
      class_property client_id : String? = nil

      # Client secret for authentication.
      class_property client_secret : String? = nil

      # The default type to use for accept headers.
      class_property default_media_type : String = Default.default_media_type

      # `Halite::Options` to be used for all connections.
      class_property connection_options : Halite::Options = Default.connection_options

      # Array of `Halite::Feature` to be used as middleware for requests.
      class_property middleware : Array(Halite::Feature) = Default.middleware

      # The maximum results returned per page for paginated endpoints.
      class_property per_page : Int32?

      # Logger. Must be compatible with Crystal logger.
      class_property logger : Logger = Default.logger

      # Proxy to use when connecting.
      # **Note:** Crystal's `HTTP::Client` and by extension `Halite` do not yet
      # support proxy's. Therefore this option does nothing for now.
      class_property proxy : String? = nil

      # `OpenSSL` verify mode to use for SSL connections.
      # 0 is OpenSSL::SSL::NONE
      # 1 is OpenSSL::SSL::PEER
      class_property ssl_verify_mode : Int32 = Default.ssl_verify_mode

      # User Agent header to be passed to all requests.
      class_property user_agent : String = Default.user_agent

      # Password for authentication.
      class_setter password : String? = nil

      # Base URL for generated web URLs
      class_setter web_endpoint : String = Default.web_endpoint

      # API endpoint for `Client`.
      class_setter api_endpoint : String = Default.api_endpoint

      # Username for authentication.
      class_setter login : String? = nil

      # API endpoint for `EnterpriseManagementConsoleClient`
      class_setter management_console_endpoint : String? = nil

      # Password for `EnterpriseManagementConsoleClient` authentication
      class_setter management_console_password : String? = nil
    end

    # :nodoc:
    KEYS = [
      "access_token",
      "api_endpoint",
      "auto_paginate",
      "bearer_token",
      "client_id",
      "client_secret",
      "connection_options",
      "default_media_type",
      "login",
      "management_console_endpoint",
      "management_console_password",
      "middleware",
      "per_page",
      "password",
      "proxy",
      "ssl_verify_mode",
      "user_agent",
      "web_endpoint",
      "logger",
    ]

    # Yield a block allowing configuration of options.
    #
    # **Example:**
    # ```
    # @client.configure do
    #   auto_paginate = true
    # end
    # ```
    def configure(&block)
      yield
    end

    # Resets the configuration options to their defaults definied in `Default`.
    macro reset!
      {% begin %}
        {% for key in KEYS %}
          @@{{ key.id }} = Octokit::Default.options[{{ key.id.stringify }}]
        {% end %}
      {% end %}
    end

    # API endpoint for `Client`.
    def api_endpoint
      File.join(@@api_endpoint, "")
    end

    # API endpoint for `EnterpriseManagementConsoleClient`
    def management_console_endpoint
      return if @@management_console_endpoint.nil?
      File.join(@@management_console_endpoint.not_nil!, "")
    end

    # Base URL for generated web URLs
    def web_endpoint
      File.join(@@web_endpoint, "")
    end

    # The username of the authenticated user
    def login
      @@login ||= begin
        user.login if token_authenticated?
      rescue e : Exception
      end
    end

    private macro options
      {% begin %}
        [
        {% for key in KEYS %}
          [{{key.id.stringify}}, @@{{key.id}}],
        {% end %}
        ].to_h
      {% end %}
    end
  end
end
