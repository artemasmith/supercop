require 'pry'
require_relative '../../spec_helper'
require_relative '../../../lib/supercop/actions/empty_folder'

describe Supercop::Actions::EmptyFolder do
  include FakeFS::SpecHelpers

  let(:params) { { destination: './project' } }
  let(:creator) { described_class.new(params) }

  describe 'when successful creation' do
    let(:created_message) { "folders #{params[:destination]} was created" }
    it { expect(described_class.new(params)).to respond_to(:perform) }
    it { expect(described_class.new(params).perform).to eq(created_message) }
    it 'create folder' do
      allow(creator).to receive(:invalid_destination?).and_return(false)

      expect(FileUtils).to receive(:mkdir_p)

      creator.perform
    end
  end

  describe 'when invalid args' do
    let(:invalid_attributes) { 'Please provide filename and destination' }
    let(:destination) { '/no_folder' }
    let(:invalid_destination) { "There is no destination #{destination}" }
    let(:empty_params) { {} }

    it { expect { described_class.new(empty_params).perform }.to raise_error(/key not found/) }
    it 'fileutils troubles' do
      allow(creator).to receive(:invalid_destination?).and_return(false)
      allow(FileUtils).to receive(:mkdir_p).and_raise(StandardError)

      expect(creator.perform).to include('Could not')
    end

    let(:exist_message) { "Folder already exists #{params[:destination]}" }
    it 'folder exists' do
      allow(creator).to receive(:invalid_destination?).and_return(true)

      expect(creator.perform).to eq(exist_message)
    end
  end
end
