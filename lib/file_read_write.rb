# frozen_string_literal: true

# For Reading and writing data file
module FileReadWrite
  require 'json'
  def self.read_file(input_file)
    result = []
    file = File.open(input_file, 'r')
    file.each_line do |input_record|
      result.push(JSON.parse(input_record))
    end
    file.close
    result
  rescue StandardError::DataError
    p 'Invalid json data in input file'
    exit(0)
  end

  def self.write_file(output_data)
    File.open('output.json', 'w+') do |f|
      f.puts(output_data)
    end
  rescue StandardError::Error
    p 'Problem while writing output.json file'
    exit(0)
  end
end