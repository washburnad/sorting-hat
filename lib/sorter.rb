class Sorter
  def initialize(data_rows:, sort_column: 0, sort_order: 'asc')
    @data_rows = data_rows
    @sort_column = sort_column
    @sort_order = sort_order
  end

  def run
    case @sort_order
    when 'asc'
      sorted_rows
    when 'desc'
      sorted_rows.reverse 
    end
  end

  private

  def sorted_rows
    @data_rows.sort_by { |row| row[@sort_column] }
  end
end