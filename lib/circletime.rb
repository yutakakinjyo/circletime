require "circletime/version"
require 'circleci'
require 'dotenv'
require 'date'
require 'active_support'
require 'active_support/core_ext'

module CircleTime
  class BuildTime
    def initialize(org)
      CircleCi.configure do |config|
        config.token = ENV['CIRCLE_CI_TOKEN']
      end
      @res = CircleCi.organization org
    end

    def today
      sum_build_time org do |date|
        today = DateTime.now
        DateTime.parse(date).new_offset(Rational(9, 24)).to_date == today.to_date
      end
    end

    def yestaday
      sum_build_time org do |date|
        yestaday = DateTime.now.prev_day
        DateTime.parse(date).new_offset(Rational(9, 24)).to_date == yestaday.to_date
      end
    end

    def week
      sum_build_time org do |date|
        current = DateTime.parse(date).new_offset(Rational(9, 24)).to_date
        DateTime.now.beginning_of_week.to_date <= current && current  <= DateTime.now.end_of_week.to_date
      end
    end

    def month
      sum_build_time org do |date|
        current = DateTime.parse(date).new_offset(Rational(9, 24)).to_date
        DateTime.now.beginning_of_month.to_date <= current && current  <= DateTime.now.end_of_month.to_date
      end
    end

    private

    def sum_build_time
      @res.body.each do |hash|
        info = OpenStruct.new(hash)
        next unless info.start_time
        if yield info.start_time
          build_sum += info.build_time_millis if info.build_time_millis
        end
      end
    end
  end
end
