require 'optparse'
require_relative './lib/validator'
require_relative './lib/file_read_write'
require_relative './lib/translation_delivered'
require_relative './lib/utility'
require_relative './lib/aggregator'

# This will hold flag option which will be passed
flag_options = {}

# Parsing the flag value sent with the application
OptionParser.new do |opts|
  opts.on('--input_file filename', 'Input json file for translation delivered') do |value|
    flag_options[:input_file] = value
  end

  opts.on('--window_size windowsize', 'Input window size for translation output') do |value|
    flag_options[:window_size] = value.to_i
  end
end.parse!

exit(0) unless Validator.valid_flag_values?(flag_options)

input_data = FileReadWrite.read_file(flag_options[:input_file])

translations_delivered = Utility.convert_to_object(input_data)

# Sorting data based on timestamp in case events.json don't have entries sorted according to timestamp
translations_delivered.sort! { |a, b| a.timestamp <=> b.timestamp }

output_data = Aggregator.aggregate_translation(translations_delivered,flag_options[:window_size])

FileReadWrite.write_file(output_data) if output_data.length

exit(1)