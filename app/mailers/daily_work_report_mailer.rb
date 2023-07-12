class DailyWorkReportMailer < ApplicationMailer
    def post_created
        @greeting = "Hi"

        mail to: User.find(6).email, cc: User.all.pluck(:email), bcc: "Ayush@vebuin.com"

        # mail to: User.find(EmailHierarchy.find_by(user_id: 13).to).email, cc: User.find((EmailHierarchy.find_by(user_id: current_user.id).cc).split(',')).pluck(:email), bcc: "Ayush@vebuin.com"
        # <% c = current_user.email_hierarchy[:to].to_i %>

        # Cc = 
        # <%= User.find(a.split(',')).pluck(:email)%>
    end
    def new_work_report_notification(work_report)
        
        # binding.pry
        
        @work_report = work_report
        @user = work_report.user.email
        @to = User.find(EmailHierarchy.find_by(user_id: work_report.user_id).to).email
        @cc = User.find((EmailHierarchy.find_by(user_id: work_report.user_id).cc).split(',')).pluck(:email)
        # @admin_emails = User.where(role: [:super_admin, :company_admin]).pluck(:email)
    
        # Send email to leader
        mail(
            from: @user,
            to: @to,
            cc: @cc,
            subject: 'New Work Report Created'
        )
    
        # # Send email to manager
        # mail(to: @manager.email, subject: 'New Work Report Created') if @manager.present?
    
        # # Send email to admins
        # mail(to: @admin_emails, subject: 'New Work Report Created') if @admin_emails.present?
    end

end
