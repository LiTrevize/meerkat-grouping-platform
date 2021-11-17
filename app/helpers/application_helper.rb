module ApplicationHelper
    def timef(datetime)
        if not datetime
            return ''
        end
        time = datetime.localtime
        # time = Time.parse(datetime).in_time_zone("Pacific Time (US & Canada)")
        time.strftime("%-m/%-d/%y %H:%M:%S")
    end

    def datef(date)
        if not date
            return ''
        end
        date.strftime("%-m/%-d/%y")
    end

    def interval_format(left, right)
        if not left and not right
            return ''
        end
        if left == right
            return left
        end
        return [left, right].join(' - ')
    end
end
