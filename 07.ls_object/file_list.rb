# frozen_string_literal: true

class FileList
  attr_reader :files_info, :file_path

  def initialize(file_path, has_hidden_file)
    @file_path = file_path
    @files_info = coreate_files_info(has_hidden_file)
  end

  def reverse
    @files_info.reverse!
  end

  def max_length(key)
    @files_info.map { |file| file.send(key).length }.max
  end

  def sum_blocks
    @files_info.sum(&:block)
  end

  private

  def fetch_files(has_hidden_file)
    has_hidden_file ? Dir.glob('*', base: @file_path).sort : Dir.entries(@file_path).sort
  end

  def fetch_file_stat(file_name)
    Dir.chdir(@file_path) { File.lstat(file_name) }
  end

  def coreate_files_info(has_hidden_file)
    files = fetch_files(has_hidden_file)
    files.map do |file_name|
      file_stat = fetch_file_stat(file_name)
      FileInfo.new(file_name, file_stat)
    end
  end
end
