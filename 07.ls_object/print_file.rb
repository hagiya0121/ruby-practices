# frozen_string_literal: true

class PrintFile
  COLUMN_COUNT = 3
  PADDING = 4

  def self.print_file_path(file_path)
    puts file_path
  end

  def self.print_files(files)
    max_length = files.map { |file| file.name.length }.max
    formatted_files = format_files(files)
    formatted_files.each do |row_files|
      puts row_files.compact.map { |file| file.name.ljust(max_length + PADDING) }.join
    end
  end

  def self.format_files(files)
    row_count = (files.length.to_f / COLUMN_COUNT).ceil
    files.fill(nil, files.size...row_count * COLUMN_COUNT)
    files.each_slice(row_count).to_a.transpose
  end
end
