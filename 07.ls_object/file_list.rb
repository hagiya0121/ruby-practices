# frozen_string_literal: true

class FileList
  attr_reader :files_info, :file_path

  def initialize(file_path, all: false)
    @file_path = file_path
    @files_info = if all
                    create_all_files_info
                  else
                    create_files_info
                  end
  end

  def reverse
    @files_info.reverse!
  end

  def max_length(key)
    @files_info.map { |file| file.send(key).length }.max
  end

  def total_block
    @files_info.sum(&:block)
  end

  private

  def create_files_info
    files = Dir.glob('*', base: @file_path).sort
    files.map do |name|
      file_stat = get_file_stat(name)
      FileInfo.new(name, file_stat)
    end
  end

  def create_all_files_info
    files = Dir.entries(@file_path).sort
    files.map do |name|
      file_stat = get_file_stat(name)
      FileInfo.new(name, file_stat)
    end
  end

  def get_file_stat(name)
    Dir.chdir(@file_path) { File.lstat(name) }
  end
end
