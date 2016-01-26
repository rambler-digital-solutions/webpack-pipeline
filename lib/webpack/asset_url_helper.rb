module Webpack
  module AssetUrlHelper
    extend ActiveSupport::Concern

    included do
      def compute_asset_path(source, options = {})
        webpack.asset_url(source) || super
      end

      protected

      def webpack
        @webpack ||= Manifest.instance
      end
    end
  end
end
