require File.expand_path(File.dirname(__FILE__) + 'spec_helper')

describe Webpack::Manifes do
  subject { Webpack::Manifes.instanse }

  describe 'config manifest path' do
    it 'default to public/assets/manifest.json'
    it 'changing by configuration'
  end
  it 'asset_url return nil if asset not found'
  it 'take host from publicPath attribute'
  it 'find asset by filename with extension'
end
