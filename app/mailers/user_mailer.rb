class UserMailer < ActionMailer::Base
  default from: "notifications@testifiable.com"

  def welcome_email(user)
  	@user = user
  	@url = 'http://testifiable.com/sessions/new'
  	mail(to: @user.email, subject: 'Welcome to testifiable')
  end

  def reminder_email(user,experiment)
  	@user = user
  	@experiment = experiment
  	#@url = 'http://testifiable.com/sessions/new'
  	subject = "What is the impact of " + @experiment.action + " vs. " + @experiment.control + " on " + @experiment.outcome + "?"
  	mail(to: @user.email, subject: '[testifiable] '+ subject)
  end
end
