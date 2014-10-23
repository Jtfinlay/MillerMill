require './cron'
require './contract_timed_message'

module TimedMessage
  def TimedMessage.schedule_message(time, message)
    pre_schedule_message(time, message)
    fork do
      begin
        Cron.timed_message(time, message)
        sleep(time)
      rescue SystemCallError => e
        $stdout << e.message
        $stdout << e.backtrace.inspect
        return
      end
    end
    post_schedule_message(time, message)
  end
end
