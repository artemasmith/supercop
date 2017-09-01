require 'spec_helper'

describe Supercop::Actions::Clean do
  describe '#call' do
    it { expect(described_class).to respond_to(:call) }

    context 'when delete only config' do
      let(:clean_gemfile_result) { { gemfile: '', changed: false } }
      before do
        allow(described_class).to receive(:clean_gemfile)
          .and_return(clean_gemfile_result)

        allow(described_class).to receive(:remove_config)
      end

      it 'delete config' do
        expect(described_class).to receive(:remove_config)

        described_class.call
      end
    end

    context 'when restore gemfile' do
      let(:clean_gemfile_result) { { gemfile: '', changed: true } }
      before do
        allow(described_class).to receive(:clean_gemfile)
          .and_return(clean_gemfile_result)

        allow(described_class).to receive(:remove_config)
        allow(described_class).to receive(:restore_gemfile)
        allow(described_class).to receive(:update_bundle)
      end

      it 'restore gemfile' do
        expect(described_class).to receive(:restore_gemfile)
        expect(described_class).to receive(:update_bundle)

        described_class.call
      end
    end
  end
end
