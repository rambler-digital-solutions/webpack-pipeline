module Webpack
  module AssetUrlHelper
    extend ActiveSupport::Concern

    included do
      def compute_asset_path(source, options = {})
        webpack.asset_url(source) || fail(ArgumentError, "can't find #{source}")
      end

      protected

      def webpack
        @webpack ||= Manifest.instance
      end
    end
  end
end
