# Sends mails when content is created or updated
class ContentMailer < ActionMailer::Base
  default from: 'notifications@catalogue.com'

  def content_created_email(user, obj)
    @user = user
    @obj = obj
    @url = url_for_obj(obj)
    User.approvers.each do |approver|
      mail(to: approver.email,
           subject: "[CATALOGUE] - #{@user.name} has created new content!")
    end
  end

  def content_updated_email(user, obj)
    @user = user
    @obj = obj
    if @obj.creator != @user
      mail(to: @obj.creator.email,
           subject: "[CATALOGUE] - #{@user.name} updated your #{@obj.class.to_s.downcase}")
    end
  end

  private

  def url_for_obj(object)
    case object.class
    when Article
      link_to object.title, article_url(object)
    when Document
      link_to object.title, document_url(object)
    when Link
      link_to object.title, link_url(object)
    end
  end
end
