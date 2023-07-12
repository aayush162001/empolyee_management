# Preview all emails at http://localhost:3000/rails/mailers/daily_work_report_mailer
class DailyWorkReportMailerPreview < ActionMailer::Preview
    def post_created
        DailyWorkReportMailer.post_created
    end
    def new_work_report_notification
        @work_report = DailyWorkReport.last
        DailyWorkReportMailer.new_work_report_notification(@work_report)
    end
end
