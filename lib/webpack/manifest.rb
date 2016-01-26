require 'webpack/configuration'

module Webpack
  class Manifest
    include Singleton

    cattr_reader :configuration do
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end

    def asset_url(source)
      return unless manifest_found?

      asset_name = asset_in_chunks(source) || asset_images(source)
      "#{host}#{asset_name}" if asset_name
    end

    def host
      data['publicPath']
    end

    protected

    def asset_in_chunks(source)
      name = source.split('.').first
      ext  = source.split('.').last
      chunk = [*data['assetsByChunkName'][name]]

      chunk.find { |asset| asset.end_with? ext }
    end

    def asset_images(source)
      data['assets'][source]
    end

    def data
      new_timestamp = File.ctime(configuration.path)
      return @data if new_timestamp == @updated_at
      @updated_at = new_timestamp
      @data = JSON.parse(File.read(configuration.path))
    end

    def manifest_found?
      File.exist? configuration.path
    end
  end
end
