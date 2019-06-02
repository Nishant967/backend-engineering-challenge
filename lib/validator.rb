# frozen_string_literal: true

# For Validating flag values sent with cli
module Validator
  def self.valid_flag_values?(options)
    if !File.file?(options[:input_file].strip) || File.zero?(options[:input_file].strip)
      p 'Invalid value of input file flag'
      return false
    end

    if options[:window_size] < 1
      p 'Invalid value of window size flag : minimum value 1'
      return false
    end
    true
  end
end