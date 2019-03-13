# frozen_string_literal: true

class ConfigFile
  attr_reader :destination

  def initialize(file)
    @destination = File.join(Dir.home, file)
  end

  def destination_empty?
    !File.exist?(@destination)
  end

  def to_s
    link = "#{name} -> #{destination}"

    if error
      "[#{Rainbow('error').red}] #{link}: #{Rainbow(error).red}"
    else
      "[#{Rainbow('success').green}] #{link}"
    end
  end

  private

  def backup_file_at_destination
    backup_file = "#{destination}.bkp"
    FileUtils.mv(destination, backup_file)
  end
end
