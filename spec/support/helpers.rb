def helper
  Helper.instance
end

class Helper
  include Singleton
  include ActionView::Helpers::AssetUrlHelper
  include Webpack::AssetUrlHelper
end
