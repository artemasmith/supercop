require 'spec_helper'

describe Supercop::Parsers::Base do
  context 'when success parse' do
    let(:json) { [{}, {}].to_json }
    let(:warnings_count) { 2 }

    subject { described_class.new(json).call }

    it { is_expected.to eq(warnings_count) }
  end
end
