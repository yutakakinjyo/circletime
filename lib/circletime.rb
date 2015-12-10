require "circletime/version"
require 'circleci'
require 'dotenv'
require 'date'
require 'active_support'
require 'active_support/core_ext'

module CircleTime
  class BuildTime

    def initialize(org)
      Dotenv.load
      CircleCi.configure do |config|
        config.token = ENV['CIRCLE_CI_TOKEN']
      end
      @res = CircleCi.organization org
    end

    def today
      sum_build_time do |build_day|
        today = DateTime.now.to_date
        build_day == today
      end
    end

    def yestaday
      sum_build_time do |build_day|
        yestaday = DateTime.now.prev_day.to_date
        build_day == yestaday
      end
    end

    def week
      sum_build_time do |build_day|
        beginning_day = DateTime.now.beginning_of_week.to_date
        end_day       = DateTime.now.end_of_week.to_date

        beginning_day <= build_day && build_day  <= end_day
      end
    end

    def month
      sum_build_time do |build_day|
        beginning_day = DateTime.now.beginning_of_month.to_date
        end_day       = DateTime.now.end_of_month.to_date

        beginning_day <= build_day && build_day  <= end_day
      end
    end

    private

    def sum_build_time
      build_sum = 0
      @res.body.each do |hash|
        info = OpenStruct.new(hash)
        next unless info.start_time
        build_day = DateTime.parse(info.start_time).new_offset(Rational(9, 24)).to_date
        if yield build_day
          build_sum += info.build_time_millis if info.build_time_millis
        end
      end
      (build_sum / 1000.0 / 60)
    end

  end
end
