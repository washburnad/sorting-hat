require 'csv'

class CsvSorter
	COMMA_SEPARATOR = ','.freeze

	def initialize(column_separator: COMMA_SEPARATOR, path:, sort_column: 0)
		@column_separator = column_separator
		@path = path
		@sort_column = sort_column
	end

	def run
		data_rows.sort_by { |row| row[@sort_column] }
	end

	def csv
		@csv ||= CSV.new(data_str, col_sep: @column_separator)
	end

	def data_rows
		csv.read
	end

	def data_str
		File.read(@path)
	end
end