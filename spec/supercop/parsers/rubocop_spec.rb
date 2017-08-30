require 'spec_helper'

describe Supercop::Parsers::Rubocop do
  context 'when success parse' do
    let(:json) { { 'summary' => { 'offense_count' => warnings_count }}.to_json }
    let(:warnings_count) { 2 }

    subject { described_class.new(json).call }

    it { is_expected.to eq(warnings_count) }
  end

  context 'when parse with errors' do
    let(:json) { { 'summary' => {} }.to_json }

    subject { described_class.new(json).call }

    it { is_expected.to eq('none') }
  end
end
