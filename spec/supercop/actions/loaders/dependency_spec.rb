require 'spec_helper'

describe Supercop::Actions::Loaders::Dependency do
  let(:gems) { [:aa_parser] }
  let(:service) { described_class.new }
  before do
    allow(Supercop.configuration).to receive(:cops_settings).and_return({})
    allow(Supercop.configuration.cops_settings).to receive(:keys).and_return(gems)
  end

  describe 'when load smth' do
    context 'when rails' do
      before do
        stub_const('Rails', '')
        allow(service).to receive(:new_gems_added?).and_return(false)
      end

      it 'all was required' do
        expect(service).to receive(:say_nothing_needed)
        expect(service).not_to receive(:install)

        service.perform
      end
    end
  end

  describe 'when no need to load' do
    # TODO: Define do I need to stub Rails
    before do
      allow(service).to receive(:new_gems_added?).and_return(true)
      allow(service).to receive(:install)
    end

    it 'nothing was loaded' do
      expect(service).not_to receive(:say_nothing_needed)
      expect(service).to receive(:install)

      service.perform
    end
  end
end
