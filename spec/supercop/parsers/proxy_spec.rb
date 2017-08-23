require 'spec_helper'

shared_examples_for 'your_parser' do |linter, parser_class, expected_class|
  let(:json) { {}.to_json }

  subject { parser_class.new(json, linter) }

  its('parser.class.name') { is_expected.to eq(expected_class) }
end

describe Supercop::Parsers::Proxy do
  describe 'when parsing of your linter is fine' do
    # Dirty hack to avoid 'let' shared example error
    RUBOCOP_CLASS = 'Supercop::Parsers::Rubocop'.freeze

    context 'when haml' do
      it_behaves_like 'your_parser', 'haml_lint', described_class, RUBOCOP_CLASS
    end

    context 'when slim' do
      it_behaves_like 'your_parser', 'slim_lint', described_class, RUBOCOP_CLASS
    end

    context 'when slim' do
      it_behaves_like 'your_parser', 'rubocop', described_class, RUBOCOP_CLASS
    end

    context 'when scss_lint' do
      SCSS_LINT = 'Supercop::Parsers::ScssLint'.freeze
      it_behaves_like 'your_parser', 'scss_lint', described_class, SCSS_LINT
    end
  end
end
