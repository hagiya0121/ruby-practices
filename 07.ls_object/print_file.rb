# frozen_string_literal: true

class PrintFile
  COLUMN_COUNT = 3
  PADDING = 4

  def self.print_files(files)
    row_count = (files.length.to_f / COLUMN_COUNT).ceil
    max_length = files.max_by { |file| file.name.length }.name.length
    files += [nil] * (row_count * COLUMN_COUNT - files.size)
    grid_files = files.each_slice(row_count).to_a.transpose

    grid_files.each do |row|
      puts row.compact.map { |file| file.name.ljust(max_length + PADDING) }.join
    end
  end
end
