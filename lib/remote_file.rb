require 'net/http'
require 'yaml'
require_relative 'config_file'

class RemoteFile < ConfigFile
  attr_reader :src, :name

  def initialize(file)
    remote_files = YAML.load_file('remote_files.yml')
    @src = remote_files[file]
    @name = remote_files[file]
    super
  end

  def src_content
    @src_content ||= Net::HTTP.get(URI.parse(@src))
  end

  def error
    return "remote file hasn't been downloaded" if destination_empty?

    return 'remote file not up to date with remote' if src_content != File.read(@destination)

    nil
  end

  def setup
    case error
    when 'remote file not up to date with remote'
      backup_file_at_destination
      create
    when "remote file hasn't been downloaded"
      create
    end
  end

  private

  def create
    FileUtils.mkdir_p(File.dirname(destination))
    File.write(destination, src_content)
  end
end
