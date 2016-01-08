my_formats = {
  :short_date => '%-m/%-d/%Y',              # 3/2/2010
  :time => "%-I:%M %p ",                    # 2:06 pm
  :month_year => "%b %Y",                   # Mar 2010
  :month_day_year => "%B %-d, %Y",          # March 2, 2010
  :sync => '%m/%d/%Y %T',                   # 3/2/2010 02:06:00    ( or 3/2/2010 02:06:00 for morning)
  :date_and_time => "%B %-d, %Y %l:%M %p",  # March 2, 2010 2:06 pm
  :date => "%B %-d, %Y",                    # March 2, 2010,
  :weekday_month_day_year => "%A, %B %-d, %Y",  # Tuesday, March 2, 2010
}
Time::DATE_FORMATS.merge!(my_formats)
Date::DATE_FORMATS.merge!(my_formats)