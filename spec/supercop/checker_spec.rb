require 'spec_helper'

describe Supercop::Checker do
  describe 'parsing is ok' do
    let(:cop_check_result) { ['ruocop', 0, 10, 'ok'] }
    let(:cop) { Supercop::Cop.new('rubocop') }
    let(:printer) { Supercop::TableFormatter.new }

    subject { described_class.new }

    before do
      allow(subject.cop).to receive(:new).and_return(cop)
      allow(cop).to receive(:handle).and_return(cop_check_result)
      allow(subject.printer).to receive(:new).and_return(printer)
      allow(printer).to receive(:print_table)
    end

    it 'calling cop' do
      expect(cop).to receive(:handle)
      subject.call
    end

    it 'calling printer' do
      expect(printer).to receive(:print_table)
      subject.call
    end
  end
end
