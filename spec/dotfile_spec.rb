require 'dotfile'

RSpec.describe Dotfile do
  subject(:dotfile) { Dotfile.new('foo/dotfile') }

  before do
    allow(Dir).to receive(:home).and_return('/home/user/')
    #  allow(File).to receive(:expand_path).with('foo/dotfile').and_return('/project/foo/dotfile')
  end

  it 'expands the source relative to the project folder' do
    expect(dotfile.src).to end_with('/foo/dotfile')
  end

  it 'builds a destination relative to the home dir' do
    expect(dotfile.destination).to eq('/home/user/foo/dotfile')
  end

  it { is_expected.to be_destination_empty }

  it 'returns an error' do
    expect(dotfile.error).to eq('link missing')
  end

  it 'can be setup' do
    allow(FileUtils).to receive(:mkdir_p)
    allow(File).to receive(:symlink)

    dotfile.setup

    expect(FileUtils).to have_received(:mkdir_p).with('/home/user/foo')
    expect(File).to have_received(:symlink).with(dotfile.src, '/home/user/foo/dotfile')
  end

  context 'when a file exists at the destination' do
    before do
      allow(File).to receive(:exist?).with(dotfile.destination).and_return(true)
    end

    it { is_expected.not_to be_destination_empty }

    it 'returns an error' do
      expect(dotfile.error).to eq('file exists at destination')
    end

    it 'can be setup' do
      allow(FileUtils).to receive(:mv)
      allow(FileUtils).to receive(:mkdir_p)
      allow(File).to receive(:symlink)

      dotfile.setup

      expect(FileUtils).to have_received(:mv).with('/home/user/foo/dotfile', '/home/user/foo/dotfile.bkp')
      expect(FileUtils).to have_received(:mkdir_p).with('/home/user/foo')
      expect(File).to have_received(:symlink).with(dotfile.src, dotfile.destination)
    end
  end

  it { is_expected.not_to be_linked }

  context 'when a link points to different destination' do
    before do
      allow(File).to receive(:symlink?).with(dotfile.destination).and_return(true)
      allow(File).to receive(:readlink).with(dotfile.destination).and_return('/foo')
    end

    it { is_expected.not_to be_linked }
  end

  context 'when a linnk points to the source file' do
    before do
      allow(File).to receive(:symlink?).with(dotfile.destination).and_return(true)
      allow(File).to receive(:readlink).with(dotfile.destination).and_return(dotfile.src)
      allow(File).to receive(:exist?).with(dotfile.destination).and_return(true)
    end

    it { is_expected.to be_linked }

    it 'returns success' do
      expect(dotfile.error).to be_nil
    end
  end
end
