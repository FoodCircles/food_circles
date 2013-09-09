class InboxController < ApplicationController
  include Mandrill::Rails::WebHookProcessor
  
  def handle_inbound(event_payload)
    if message = event_payload.msg.presence
      from_email = msg.from_email
      mail_subject = msg.subject
      mail_text = msg.text
      
      inbound_mark_used(from_email, mail_subject, mail_text)
    end
    render :nothing => true
  end
  
  def inbound_mark_used(from_email, mail_subject, mail_text)
    from = from_email
    subject = mail_subject
    text = mail_text
    
    if (subject == "used")
      payment = Payment.find_by_code(text)      
      payment.state = "Used"
      payment.save
    else
      #This needs to be updated to lookup payment by from e-mail
      payment = Payment.find_by_code(text)
      payment.state = "Used"
      payment.save
    end
      
    render :nothing => true
  end
end
