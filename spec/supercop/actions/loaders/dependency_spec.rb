require 'spec_helper'

describe Supercop::Actions::Loaders::Dependency do
  let(:gem_name) { :aa_parser }
  let(:gems) { [gem_name] }
  let(:service) { described_class.new }
  before do
    allow(Supercop.configuration).to receive(:cops_settings).and_return({})
    allow(Supercop.configuration.cops_settings).to receive(:keys).and_return(gems)
    allow(Supercop.configuration).to receive(gem_name).and_return({})
  end

  context 'when load smth' do
    before do
      stub_const('Rails', '')
      allow(service).to receive(:gems_to_add).and_return([])
    end

    it 'all was required' do
      expect(service).to receive(:say_nothing_needed)
      expect(service).not_to receive(:install)

      service.call
    end
  end

  context 'when no need to load' do
    # TODO: Define do I need to stub Rails
    before do
      allow(service).to receive(:gems_to_add).and_return([gem_name])
      allow(service).to receive(:install)
    end

    it 'nothing was loaded' do
      expect(service).not_to receive(:say_nothing_needed)
      expect(service).to receive(:install)

      service.call
    end
  end
end
