# frozen_string_literal: true

class FileList
  attr_reader :files_info, :file_path

  def initialize(file_path, include_hidden_file)
    @file_path = file_path
    @files_info = create_files_info(include_hidden_file)
  end

  def reverse!
    @files_info.reverse!
  end

  def max_length(key)
    @files_info.map { |file| file.send(key).length }.max
  end

  def sum_blocks
    @files_info.sum(&:block)
  end

  private

  def fetch_files(include_hidden_file)
    include_hidden_file ? Dir.entries(@file_path).sort : Dir.glob('*', base: @file_path).sort
  end

  def fetch_file_stat(file_name)
    Dir.chdir(@file_path) { File.lstat(file_name) }
  end

  def create_files_info(include_hidden_file)
    files = fetch_files(include_hidden_file)
    files.map do |file_name|
      file_stat = fetch_file_stat(file_name)
      FileInfo.new(file_name, file_stat)
    end
  end
end
