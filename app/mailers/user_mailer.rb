# encoding: UTF-8
class UserMailer < ActionMailer::Base
  def general(to_address, from_address, subject, body)
    mail(:to => to_address, :from => from_address, :subject => subject, :body => body).deliver
  end
end
