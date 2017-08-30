require 'spec_helper'

describe Supercop::Actions::FileInjector do
  let(:params) { { filename: '/Gemfile', line: 'sdfds' } }
  let(:service) { described_class.new(params) }

  context 'when nothing insert' do
    before { allow(service).to receive(:file_include?).and_return(true) }

    it 'line already exist' do
      expect(service).not_to receive(:insert_into_file)

      service.call
    end
  end

  context 'when insert' do
    before do
      allow(service).to receive(:file_include?).and_return(false)
      allow(service).to receive(:insert_into_file)
      allow(service).to receive(:sanitized)
    end

    it 'insert new line' do
      expect(service).to receive(:insert_into_file)

      service.call
    end
  end
end
