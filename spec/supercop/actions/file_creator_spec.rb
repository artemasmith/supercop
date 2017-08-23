require 'pry'
require_relative '../../spec_helper'

describe Supercop::Actions::ConfigCopier do
  include FakeFS::SpecHelpers

  let(:params) { { filename: 'file', destination: './project' } }
  let(:creator) { described_class.new(params) }

  describe 'when successful creation' do
    it { expect(described_class.new(params)).to respond_to(:perform) }
    it 'create file' do
      allow(creator).to receive(:invalid_destination?).and_return(false)

      expect(FileUtils).to receive(:copy)

      creator.perform
    end
  end

  describe 'when invalid args' do
    let(:invalid_destination) { "There is no destination #{destination}" }
    let(:invalid_params) { { destination: destination } }
    let(:destination) { '/no_folder' }
    let(:empty_params) { {} }

    it { expect { described_class.new(empty_params).perform }.to raise_error(/key not found/) }
    it 'fileutils troubles' do
      allow(creator).to receive(:invalid_destination?).and_return(false)
      allow(FileUtils).to receive(:copy).and_raise(StandardError)

      expect(creator.perform).to include('Could not')
    end

    it { expect(described_class.new(invalid_params).perform).to eq(invalid_destination) }
  end
end
