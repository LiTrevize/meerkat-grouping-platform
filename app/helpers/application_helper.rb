module ApplicationHelper
    def time_format(datetime)
        time = datetime.localtime
        # time = Time.parse(datetime).in_time_zone("Pacific Time (US & Canada)")
        time.strftime("%-m/%-d/%y %H:%M:%S")
    end
end
