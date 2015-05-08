require 'webpack/configuration'

module Webpack
  class Manifest
    include Singleton
    attr_reader :updated_at
    cattr_reader :configuration do
      @configuration ||= Configuration.new
    end

    class << self
      def configure
        yield configuration
      end
    end

    def javascripts
      @javascript = find_asset { |file_name| file_name.ends_with? 'js' }
    end

    def stylesheets
      @stylesheets = find_asset { |file_name| file_name.ends_with? 'css' }
    end

    def find_asset(&block)
      chunks.inject({}) do |hash, chunk|
        filenames = [*data['assetsByChunkName'][chunk]]
        if finded = filenames.find(&block)
          hash.merge chunk => "#{host}#{finded}".strip
        else
          hash
        end
      end
    end

    def host
      data['publicPath']
    end

    protected

    def data
      new_timestamp = File.ctime(configuration.path)
      if new_timestamp == @updated_at
        @data
      else
        @updated_at = new_timestamp
        @data = JSON.parse(File.read(configuration.path))
      end
    end

    def chunks
      @chunks ||= data['assetsByChunkName'].map(&:first)
    end
  end
end
