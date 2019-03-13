# frozen_string_literal: true

require 'rainbow'
require_relative 'config_file'

class Dotfile < ConfigFile
  attr_reader :name, :src

  def initialize(file)
    @name = file
    @src = File.expand_path(file)
    super
  end

  def linked?
    File.symlink?(@destination) && (File.readlink(@destination) == @src)
  end

  def error
    return 'link missing' if destination_empty?
    return 'file exists at destination' unless linked?

    nil
  end

  def setup
    case error
    when 'file exists at destination'
      backup_file_at_destination
      symlink
    when 'link missing'
      symlink
    end
  end

  private

  def symlink
    FileUtils.mkdir_p(File.dirname(destination))
    File.symlink(src, destination)
  end
end
