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

  def self.print_long_files(files_info)
    file_stats = files_info.map(&:file_stats)
    max_lengths = get_max_lengths(file_stats)
    puts "total #{file_stats.sum { |stat| stat[:block] }}"
    file_stats.each do |stat|
      puts  "#{stat[:mode]}\s\s" \
            "#{stat[:link].rjust(max_lengths[:link])}\s" \
            "#{stat[:owner].ljust(max_lengths[:owner])}\s\s" \
            "#{stat[:group].ljust(max_lengths[:group])}\s\s" \
            "#{stat[:size].rjust(max_lengths[:size])}\s\s" \
            "#{stat[:time]}\s" \
            "#{stat[:name]}"
    end
  end

  def self.format_files(files)
    row_count = (files.length.to_f / COLUMN_COUNT).ceil
    files.fill(nil, files.size...row_count * COLUMN_COUNT)
    files.each_slice(row_count).to_a.transpose
  end

  def self.get_max_lengths(file_stats)
    keys = %i[link owner group size time]
    keys.map do |key|
      [key, file_stats.map { |stat| stat[key].length }.max]
    end.to_h
  end
end
