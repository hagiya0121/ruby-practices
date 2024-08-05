# frozen_string_literal: true

require 'etc'

class FileInfo
  attr_reader :name

  PERMISSION_SYMBOLS = ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx'].freeze
  FILETYPE_SYMBOLS = { file: '-', directory: 'd', link: 'l', characterSpecial: 'c',
                       blockSpecial: 'b', fifo: 'p', socket: 's' }.freeze

  def initialize(name)
    @name = name
  end

  def file_stats
    file_stat = File.lstat(@name)
    permission = file_stat.mode.to_s(8)[-3..]
    symbolic_permission = permission.chars.map { |char| PERMISSION_SYMBOLS[char.to_i] }.join
    file_type = file_stat.ftype.to_sym
    {
      block: file_stat.blocks,
      mode: FILETYPE_SYMBOLS[file_type] + symbolic_permission,
      link: file_stat.nlink.to_s,
      owner: Etc.getpwuid(file_stat.uid).name,
      group: Etc.getgrgid(file_stat.gid).name,
      size: file_stat.size.to_s,
      time: file_stat.atime.strftime('%-m %e %H:%M'),
      name: file_type == :link ? "#{@name} -> #{File.readlink(@name)}" : @name
    }
  end
end
