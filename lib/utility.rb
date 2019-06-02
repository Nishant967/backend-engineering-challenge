# frozen_string_literal: true

# For basic utilities
module Utility
  # Convert json array to object array

  def self.convert_to_object(input_data)
    input_data.map { |td|
      TranslationDelivered.new(td['timestamp'], td['translation_id'], td['source_language'],
                               td['target_language'], td['client_name'], td['event_name'],
                               td['duration'], td['nr_words']
      )}
  end

  # Trim unwanted trailing zero
  def self.trim_avg_value(number)
    i = number.to_i
    f = number.to_f
    i == f ? i : f
  end
end