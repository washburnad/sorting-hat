require_relative 'sorter'
require_relative 'reader'

class SortingHat
  DEFAULT_SORT_COLUMN = 0
  DEFAULT_SORT_ORDER = 'asc'.freeze 

  def initialize(path:, sort_column: DEFAULT_SORT_COLUMN, sort_order: DEFAULT_SORT_ORDER)
    @path = path
    @sort_column = sort_column
    @sort_order = sort_order
  end

  def run
    data_rows = Reader.new(path: @path).run
    Sorter.new(data_rows: data_rows, sort_column: @sort_column, sort_order: @sort_order).run
  end
end