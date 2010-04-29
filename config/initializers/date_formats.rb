date_formats = {
  :w3c => lambda { |time| time.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00") },
  :month_day_year => lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") },
  :month_day => lambda { |time| time.strftime("%B #{time.day.ordinalize}") },
  :month_year => "%B %Y",
}

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(date_formats)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(date_formats)