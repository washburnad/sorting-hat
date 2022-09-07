require 'csv'
require 'logger'

# Use specific class to read an Outdoor.sy user file
# rows are either | or , delimited
# rows contain exactly 6 fields corresponding to HEADERS fields
# data can be sorted by any row or by full name

# delimiter regexes match exactly 6 values separated by delimiter
# values can be empty

# e.g. with `,` delimiter
# ",,,,," -> [ '', '', '', '', '', '' ]
# ",a,b,c,d," -> [ '', 'a', 'b', 'c', 'd', '' ]

module Outdoorsy
  class Sorter
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
      @logger = Logger.new(STDOUT)

      set_delimiter
      load_and_build_users
    end

    def sort(sort_column: :full_name, sort_order: :asc) 
      @users.sort_by! { |user| user.send(sort_column.to_sym).downcase }

      if sort_order == :desc
        @users.reverse!
      end

      log_users
    end

    private 

    def csv
      CSV.new(data_str, col_sep: @delimiter)
    end

    def data_str
      @data_str ||= File.read(@path)
    end

    def load_and_build_users
      csv.each do |row|
        @users << User.new(*row)
      end
    end

    def log_users
      @users.each do |user|
        @logger.info(user.to_s(@delimiter))
      end

      nil
    end

    def set_delimiter
      @delimiter = if data_str.match?(COMMA_REGEX)
        COMMA_DELIMITER
      elsif data_str.match?(PIPE_REGEX)
        PIPE_DELIMITER
      else
        raise(
          CSV::MalformedCSVError.new('File is not in expected Outdoorsy format', 1)
        )
      end
    end
  end
end