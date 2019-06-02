# frozen_string_literal: true

# For aggregation operation
module Aggregator
  include Utility
  # Finding average delivery time for each timestamp

  def self.find_average_delivery_time(start_time, window_size, data, length, avg_delivery_time, translation_count)
    index = 0
    while index < length
      window_time = start_time - Rational(60 * window_size, 864_00)
      if start_time >= data[index].consideration_minute_timestamp && data[index].timestamp >= window_time
        avg_delivery_time += data[index].duration
        translation_count += 1
      end
      index += 1
    end
    return 0 if avg_delivery_time.zero? && translation_count.zero?

    avg_delivery_time / translation_count.to_f
  end

  # Constructing aggregation data

  def self.aggregate_translation(data, window_size)
    result = []
    length = data.length
    start_time = data[0].minute_timestamp
    end_time = data[length - 1].consideration_minute_timestamp
    avg_delivery_time = 0
    while start_time <= end_time
      translation_count = 0
      avg_delivery_time = find_average_delivery_time(start_time, window_size, data, length, avg_delivery_time, translation_count)
      result_data = { "date": start_time.strftime('%Y-%m-%d %H:%M:%S'), "average_delivery_time": Utility.trim_avg_value(avg_delivery_time) }.to_json
      result.push(result_data)
      avg_delivery_time = 0
      start_time += Rational(60, 864_00)
    end
    result
  end
end