# use specific class to read an Outdoor.sy user file
# rows are either | or , delimited
# rows contain exactly 6 fields corresponding to HEADERS
# data can be sorted by any row or by full name

# regexes match exactly 6 values separated by delimiter
# values can be empty

# e.g. with `,` delimiter
# ",,,,," -> [ '', '', '', '', '', '' ]
# ",a,b,c,d," -> [ '', 'a', 'b', 'c', 'd', '' ]

module Outdoorsy
  class Sorter
    attr_reader :users 

    COMMA_DELIMITER = ','.freeze
    COMMA_REGEX = /\A.*(,.*){5}$/
    PIPE_DELIMITER = '|'.freeze
    PIPE_REGEX = /\A.*(\|.*){5}$/

    HEADERS = %i(
      first_name 
      last_name 
      email
      vehicle_type
      vehicle_name
      vehicle_length
    ).freeze

    User = Struct.new(*HEADERS) do 
      def full_name
        "#{first_name} #{last_name}"
      end

      def to_s(delimiter)
        [full_name, email, vehicle_type, vehicle_name, vehicle_length].join(delimiter)
      end
    end

    def initialize(path:)
      @path = path 
      @users = []

      set_delimiter
      build_users
    end

    def sort(sort_column:, sort_order:) 
      @users.sort_by! { |user| user.send(sort_column.to_sym) }

      if sort_order == 'desc'
        @users.reverse!
      end
    end

    def user_list
      @users.map { |user| user.to_s(@delimiter) }.join("\n")
    end

    private 

    def build_users
      csv.each do |row|
        @users << User.new(*row)
      end

      # require 'pry'; binding.pry
    end

    def csv
      CSV.new(data_str, col_sep: @delimiter)
    end

    def data_str
      @data_str ||= File.read(@path)
    end

    def set_delimiter
      @delimiter = if data_str.match?(COMMA_REGEX)
        COMMA_DELIMITER
      elsif data_str.match?(PIPE_REGEX)
        PIPE_DELIMITER
      else
        raise(CSV::MalformedCSVError.new('File is not in expected format', 0))
      end
    end
  end
end