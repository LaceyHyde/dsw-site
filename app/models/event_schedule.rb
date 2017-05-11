module EventSchedule
  SUBMISSION_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-03-19').freeze
  SUBMISSION_CLOSE_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-04-21').freeze

  VOTING_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-05-10').freeze
  VOTING_CLOSE_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-05-29').freeze

  REGISTRATION_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-06-26').freeze

  WEEK_START_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-09-25').freeze
  WEEK_END_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-09-29').freeze

  class << self
    def submissions_open?
      Time.zone.now > SUBMISSION_OPEN_DATE.at_beginning_of_day &&
        Time.zone.now < SUBMISSION_CLOSE_DATE.at_end_of_day
    end

    def feedback_open?
      Time.zone.now > VOTING_OPEN_DATE.at_beginning_of_day &&
        Time.zone.now < VOTING_CLOSE_DATE.at_end_of_day
    end

    def week_started?
      Time.zone.now > WEEK_START_DATE.at_beginning_of_day
    end
  end
end