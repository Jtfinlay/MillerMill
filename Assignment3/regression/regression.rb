module Regression

  def thread_task(num_threads)
    work_per_thread = 100000 / num_threads
    threads = []
    t1 = Time.now
    (0..num_threads).each{
      |x| threads << Thread.new{(0..work_per_thread).each{Math.sqrt(100000) }}
    }
    threads.each{|t| t.join}
    t2 = Time.now
    return t2 - t1
  end

end
