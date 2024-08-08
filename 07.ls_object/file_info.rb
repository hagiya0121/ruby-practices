# frozen_string_literal: true

require 'etc'

class FileInfo
  attr_reader :name, :block, :mode, :link, :owner, :group, :size, :time

  PERMISSION_SYMBOLS = ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx'].freeze
  FILETYPE_SYMBOLS = { file: '-', directory: 'd', link: 'l', characterSpecial: 'c',
                       blockSpecial: 'b', fifo: 'p', socket: 's' }.freeze

  def initialize(name, file_stat)
    @block = file_stat.blocks
    @mode = FILETYPE_SYMBOLS[file_stat.ftype.to_sym] + symbolic_permission(file_stat)
    @link = file_stat.nlink.to_s
    @owner = Etc.getpwuid(file_stat.uid).name
    @group = Etc.getgrgid(file_stat.gid).name
    @size = file_stat.size.to_s
    @time = file_stat.atime.strftime('%-m %e %H:%M')
    @name = file_stat.ftype.to_sym == :link ? "#{name} -> #{File.readlink(name)}" : name
  end

  private

  def symbolic_permission(file_stat)
    permission = file_stat.mode.to_s(8)[-3..]
    permission.chars.map { |char| PERMISSION_SYMBOLS[char.to_i] }.join
  end
end
