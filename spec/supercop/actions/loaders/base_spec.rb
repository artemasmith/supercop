require 'spec_helper'

describe Supercop::Actions::Loaders::Base do
  let(:gem_name) { 'my_gem' }
  let(:gem_config) { { version: '0.1.0' } }
  let(:service) { described_class.new(gem_name) }

  before do
    allow(Supercop.configuration).to receive(gem_name).and_return(gem_config)
    allow(Supercop.configuration).to receive(:path).and_return('')
  end

  context 'when install a gem' do
    before { allow(service).to receive(:add_gem) }

    it 'add a gem' do
      expect(service).to receive(:add_gem)

      service.call
    end
  end

  describe 'interface check' do
    subject { service }

    it { is_expected.to respond_to(:call) }
    it { is_expected.to respond_to(:installed?) }
  end
end
