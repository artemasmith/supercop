require 'spec_helper'

describe Supercop::Actions::Loaders::Base do
  let(:gem_name) { 'my_gem' }
  let(:gem_config) { { version: '0.1.0' } }
  let(:service) { described_class.new(gem_name) }

  before do
    allow(Supercop.configuration).to receive(gem_name).and_return(gem_config)
    allow(Supercop.configuration).to receive(:path).and_return('')
  end

  describe 'when no need to install' do
    before { allow(service).to receive(:load_gem).and_return(true) }

    it 'ok' do
      expect(service).not_to receive(:add_gem)

      service.perform
    end
  end

  describe 'when needs to install' do
    before do
      allow(service).to receive(:load_gem).and_raise(LoadError)
      allow(service).to receive(:add_gem)
    end

    it 'ok' do
      expect(service).to receive(:add_gem)

      service.perform
    end
  end
end
