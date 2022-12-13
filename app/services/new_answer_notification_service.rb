class NewAnswerNotificationService
  def send_notification(object)
    subscriptions = Subscription.where(question: object.question)
    subscriptions.find_each do |subscription|
      NewAnswerMailer.notify(subscription.user, object).deliver_later
    end
  end
end
