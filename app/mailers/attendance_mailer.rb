class AttendanceMailer < ApplicationMailer
    def check_in_mail(mail_to)
        
        binding.pry
        
        @mail_to = mail_to
        @user = User.where(id:mail_to).pluck(:name)
        @to = User.where(id:mail_to).pluck(:email)
        # @cc = User.find((EmailHierarchy.find_by(user_id: mail_to).cc).split(',')).pluck(:email)
        # sadxa

        mail(
            to: @to,
            # cc: @cc,
            subject: 'Forgot to Check_In'
        )

    end

    def check_out_mail(mail_to)
        
        binding.pry
        
        @mail_to = mail_to
        @user = User.where(id:mail_to).pluck(:name)
        @to = User.where(id:mail_to).pluck(:email)
        # @cc = User.find((EmailHierarchy.find_by(user_id: mail_to).cc).split(',')).pluck(:email)
        # sadxa

        mail(
            to: @to,
            # cc: @cc,
            subject: 'Forgot to Check_out'
        )
    end
end
