require 'spec_helper'

describe Supercop::Parsers::ScssLint do
  describe 'when success parse' do
    let(:json) { { 'key1' => [{}] }.to_json }
    let(:warnings_count) { 1 }

    subject { described_class.new(json).perform }

    it { is_expected.to eq(warnings_count) }
  end

  describe 'when parse with errors' do
    let(:json) { { 'key1' => '' }.to_json }

    subject { described_class.new(json).perform }

    it { is_expected.to eq('none') }
  end
end
