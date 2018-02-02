class Dir
	def self.leaves(dir, ignore=[])
		result = []
		Dir.children(dir).each do |file|
			next if ignore.include?(file)

			if File.directory?(File.join(dir, file))
				result += Dir.leaves(File.join(dir, file)).map {|l| File.join(file, l)}
			else
				result << file
			end
		end
		result
	end
end

class Dotfile
	attr_reader :src, :destination

	def initialize(file)
		@src = File.expand_path(file)
		@destination = File.join(Dir.home, file)
	end
	
	def destination_empty?
		!File.exists?(@destination)
	end
	
	def linked?
		File.symlink?(@destination) && File.readlink(@destination) == @src	
	end

	def check
		return :error, 'link missing' if destination_empty?

		return :error, 'file exists at destination' unless linked?

		[:success, nil]
	end
end

task default: %w[help]

task :help do
	puts <<~EOS
		Usage: rake TASK

		Tasks:

		  help: Prints this message
		  check: Checks the state of the dotfiles
		  setup: Creates symlinks for all dotfiles
	EOS
end

require 'fileutils'

IGNORED_FILES = [
	'.',
	'..',
	'.git',
	'LICENSE',
	'Rakefile',
	'README.md'
]

def dotfiles
	@dotfiles ||= Dir.leaves(".", IGNORED_FILES).map {|f| Dotfile.new(f) }
end

task :check do
	dotfiles.each do |dotfile|
		status, err = dotfile.check
		puts "[#{status}] #{dotfile.src} -> #{dotfile.destination}: #{err}"
	end

	if dotfiles.any? {|d| d.check.last }
		puts "\nRun `rake setup` to fix errors"
	else
		puts "\nDotfiles setup correctly"
	end
end

task :setup do
	dotfiles.each do |dotfile|
		status, err = dotfile.check
		if err
			if err == 'file exists at destination'
				backup_file = "#{dotfile.destination}.bkp"
				FileUtils.mv(dotfile.destination, backup_file)
				puts "Created backup file: #{backup_file}"
			end
			File.symlink(dotfile.src, dotfile.destination)
			puts "Created symlink #{dotfile.destination} -> #{dotfile.src}"
		else
			puts "Nothing to do, symlink #{dotfile.destination} -> #{dotfile.src} already exists"
		end
	end
end
