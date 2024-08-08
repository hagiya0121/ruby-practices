# frozen_string_literal: true

class PrintFile
  COLUMN_COUNT = 3
  PADDING = 4

  def initialize(file_list)
    @file_list = file_list
    @files_info = file_list.files_info
  end

  def print_file_path
    puts @file_list.file_path
  end

  def print_files
    formatted_files = format_files
    formatted_files.each do |row_files|
      puts row_files.map { |file| file.name.ljust(@file_list.max_length('name') + PADDING) }.join
    end
  end

  def print_long_files
    puts "total #{@file_list.sum_blocks}"
    @files_info.each do |file|
      puts  "#{file.mode}\s\s" \
            "#{file.link.rjust(@file_list.max_length('link'))}\s" \
            "#{file.owner.ljust(@file_list.max_length('owner'))}\s\s" \
            "#{file.group.ljust(@file_list.max_length('group'))}\s\s" \
            "#{file.size.rjust(@file_list.max_length('size'))}\s\s" \
            "#{file.time}\s" \
            "#{file.name}"
    end
  end

  private

  def format_files
    row_count = (@files_info.length.to_f / COLUMN_COUNT).ceil
    filled_files_info = @files_info.dup.fill(nil, @files_info.length...row_count * COLUMN_COUNT)
    filled_files_info.each_slice(row_count).to_a.transpose.map(&:compact)
  end
end
