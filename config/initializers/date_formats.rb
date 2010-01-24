date_formats = {
  :w3c => lambda { |time| time.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00") }
}

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(date_formats)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(date_formats)