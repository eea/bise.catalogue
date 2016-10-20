# Sends mails when content is created or updated
class ContentMailer < ActionMailer::Base
  default from: 'notifications@biodiversity.europa.eu'

  def content_created_email(user, obj)
    @user = user
    @obj = obj
    @url = url_for_obj(obj)
    attachments.inline['logo.png'] = File.read('app/assets/images/bise_logo_big.png')
    User.approvers.each do |approver|
        if approver.email
            mail(to: approver.email,
                subject: "[CATALOGUE] - #{@user.name} has created new content!")
        else
            logger.warn { "Can't send email to #{approver.login} - missing email!" }
        end
    end
  end

  def content_updated_email(user, obj)
    @user = user
    @obj = obj
    @url = url_for_obj(obj)
    attachments.inline['logo.png'] = File.read('app/assets/images/bise_logo_big.png')
    if @obj.creator.present? && @obj.creator != @user && @obj.creator.email.present?
      mail(to: @obj.creator.email,
           subject: "[CATALOGUE] - #{@user.name} updated your #{@obj.class.to_s.downcase}")
    end
  end

  private

  def url_for_obj(object)
    if object.id.nil?
      ''
    else
      case object
      when Article
        article_url(object)
      when Document
        document_url(object)
      when Link
        link_url(object)
      else
        '#'
      end
    end
  end
end
