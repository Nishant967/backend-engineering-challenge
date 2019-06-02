# frozen_string_literal: true

# Representing each translation delivered as per the input file json data

class TranslationDelivered
  require 'time'

  attr_accessor :timestamp, :translation_id, :source_language, :target_language
  attr_accessor :client_name, :event_name, :duration, :nr_words, :minute_timestamp, :consideration_minute_timestamp

  def initialize(timestamp, translation_id, source_language, target_language, client_name, event_name, duration, nr_words)
    @timestamp = valid_timestamp timestamp
    @translation_id = valid_translation_id translation_id
    @source_language = source_language
    @target_language = target_language
    @client_name = client_name
    @event_name = event_name
    @duration = valid_duration duration
    @nr_words = nr_words
    @minute_timestamp = DateTime.strptime(timestamp, '%Y-%m-%d %H:%M')
    @consideration_minute_timestamp = find_consideration_time(@timestamp,@minute_timestamp)
  end

  private

  def valid_timestamp(timestamp)
     if timestamp.nil? || timestamp.strip.empty?
        p 'Invalid timestamp value in json file'
        exit(0)
     end
     DateTime.strptime(timestamp, '%Y-%m-%d %H:%M:%S.%N')
  end

  def valid_translation_id(translation_id)
     if translation_id.nil? || translation_id.strip.empty?
       p 'Invalid translation id value in json file'
       exit(0)
     end
     translation_id
  end

  def valid_duration(duration)
     if duration.nil? || !duration.is_a?(Numeric) || duration < 0
       p 'Invalid duration value in json file'
       exit(0)
     end
     duration
  end

  def find_consideration_time(timestamp, minute_timestamp)
    return minute_timestamp + Rational(60, 86400) if timestamp > minute_timestamp
    minute_timestamp
  end
end