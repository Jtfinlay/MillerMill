require './cron'

module TimedMessage
  def TimedMessage.schedule_message(time, message)
    fork do
      Cron.timed_message(time, message)
      sleep(time)
    end
  end
end
