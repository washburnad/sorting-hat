require 'csv'

class Reader
  COMMA_SEPARATOR = ','.freeze

  def initialize(column_separator: COMMA_SEPARATOR, path:)
    @column_separator = column_separator
    @path = path
  end

  def run
    CSV.new(data_str, col_sep: @column_separator).read
  end

  def data_str
    File.read(@path)
  end
end