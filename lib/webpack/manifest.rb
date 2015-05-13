require 'webpack/configuration'

module Webpack
  class Manifest
    include Singleton
    attr_reader :updated_at
    cattr_reader :configuration do
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end

    def asset_url(filename)
      name = filename.split('.').first
      ext  = filename.split('.').last
      chunk = [*data['assetsByChunkName'][name]]

      asset_name = chunk.find { |asset|
        asset.end_with? ext
      }
      "#{host}#{asset_name}" if asset_name
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
