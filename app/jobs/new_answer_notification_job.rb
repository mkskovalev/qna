class NewAnswerNotificationJob < ApplicationJob
  queue_as :default

  def perform(object)
    NewAnswerNotificationService.new.send_notification(object)
  end
end
