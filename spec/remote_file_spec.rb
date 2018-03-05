require 'remote_file'

RSpec.describe RemoteFile do
  subject(:remote_file) { RemoteFile.new('foo/remotefile') }
  let(:remote_files) { { 'foo/remotefile' => 'http://example.com/file' } }
  let(:content) { 'hello, world!' }

  before do
    allow(YAML).to receive(:load_file).with('remote_files.yml').and_return(remote_files)
    allow(Dir).to receive(:home).and_return('/home/user/')

    uri = double
    allow(URI).to receive(:parse).with(remote_file.src).and_return(uri)
    allow(Net::HTTP).to receive(:get).with(uri).and_return(content)
  end

  it 'knows the remote source' do
    expect(remote_file.src).to eq('http://example.com/file')
  end

  it 'builds a destination relative to the home dir' do
    expect(remote_file.destination).to eq('/home/user/foo/remotefile')
  end

  it { is_expected.to be_destination_empty }

  it 'returns an error' do
    expect(remote_file.error).to eq("remote file hasn't been downloaded")
  end

  it 'can be setup' do
    allow(FileUtils).to receive(:mkdir_p)
    allow(File).to receive(:write)

    remote_file.setup

    expect(FileUtils).to have_received(:mkdir_p).with('/home/user/foo')
    expect(File).to have_received(:write).with('/home/user/foo/remotefile', 'hello, world!')
  end

  context 'when a file exists at the destination' do
    before do
      allow(File).to receive(:exist?).with(remote_file.destination).and_return(true)
      allow(File).to receive(:read).with(remote_file.destination).and_return('hello, world!')
    end

    it { is_expected.not_to be_destination_empty }

    it 'returns no error' do
      expect(remote_file.error).to be_nil
    end

    context 'but has different content' do
      before do
        allow(File).to receive(:read).with(remote_file.destination).and_return('content')
      end

      it 'returns an error' do
        expect(remote_file.error).to eq('remote file not up to date with remote')
      end

      it 'can be setup' do
        allow(FileUtils).to receive(:mv)
        allow(FileUtils).to receive(:mkdir_p)
        allow(File).to receive(:write)

        remote_file.setup

        expect(FileUtils).to have_received(:mv).with('/home/user/foo/remotefile', '/home/user/foo/remotefile.bkp')
        expect(FileUtils).to have_received(:mkdir_p).with('/home/user/foo')
        expect(File).to have_received(:write).with('/home/user/foo/remotefile', 'hello, world!')
      end
    end
  end
end
