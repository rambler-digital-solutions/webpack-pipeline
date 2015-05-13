require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'pry'

describe ActionView::Helpers::AssetUrlHelper do
  describe 'asset_path' do
    context 'when chunk present' do
      let(:asset_helper) { helper.path_to_asset :test, { type: :javascript } }

      it 'should not raise error' do
        expect { asset_helper }.not_to raise_error
      end
      it 'it find js asset be chunk name' do
        expect(asset_helper).to include('ea0d453146be2145f180.application.js')
      end

      it 'it find css asset be chunk name' do
        expect(helper.path_to_asset :test, { type: :stylesheet }).to include('ea0d453146be2145f180.application.css')
      end

      it 'add path from publicPath manifest attribute' do
        expect(asset_helper).to be_start_with('/assets/')
      end
    end

    context 'when chunk not found in webpack manifest' do
      it 'set extension by type arg' do
        result = helper.path_to_asset(:not_in_manifest, type: :javascript)
        expect(result).to be_end_with('.js')
      end
      it 'keep untouched absolute URLs' do
        link = 'http://assets2.example.com/assets/application.css'
        result = helper.path_to_asset(link)
        expect(result).to eq(link)
      end
    end
  end
end
