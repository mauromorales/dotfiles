# frozen_string_literal: true

require 'yaml'
require_relative 'lib/dotfile'
require_relative 'lib/remote_file'

class Dir
  def self.leaves(dir, ignore = [])
    result = []
    Dir.children(dir).each do |file|
      next if ignore.include?(file)

      if File.directory?(File.join(dir, file))
        result += Dir.leaves(File.join(dir, file)).map { |l| File.join(file, l) }
      else
        result << file
      end
    end
    result
  end
end

task default: %w[help]

task :help do
  puts <<~TEXT
    Usage: rake TASK
    	Tasks:
    	  help: Prints this message
      check: Checks the state of the dotfiles
      setup: Creates symlinks for all dotfiles
  TEXT
end

require 'fileutils'

IGNORED_FILES = [
  '.',
  '..',
  '.byebug_history',
  '.content',
  'Gemfile',
  'Gemfile.lock',
  '.git',
  '.gitignore',
  'lib',
  'LICENSE',
  'Rakefile',
  '.rbenv',
  'README.md',
  'remote_files.yml',
  '.rspec',
  'spec',
  '.terminfo',
  'doc',
  '.yardoc',
  'tags',
  '.ruby-version'
].freeze

REMOTE_FILES = YAML.load_file('remote_files.yml')

def files
  @files ||= Dir.leaves('.', IGNORED_FILES).map do |file|
    if REMOTE_FILES.include?(file)
      RemoteFile.new(file)
    else
      Dotfile.new(file)
    end
  end
end

task :check do
  files.each do |file|
    puts file
  end

  if files.any?(&:error)
    puts "\nRun `rake setup` to fix errors"
  else
    puts "\nDotfiles setup correctly"
  end
end

task :setup do
  files.each(&:setup)
end
