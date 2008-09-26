module Drmap
  class BeanstalkWorker

    def initialize(pool)
      @pool = pool
    end

    def process
      loop do
        begin
          job_payload = next_job
          pp job_payload
          result = eval(job_payload[:proc]).call(job_payload[:data])
          save(job_payload[:jid], result)
          success!
        rescue => e
          fail!(e)
        end
      end
    end

    def next_job
      @job = @pool.next_job
      @job.ybody
    end

    def success!
      @job.delete
    end

    def fail!(e)
      puts "ERROR #{e.message}"
      e.backtrace.each do |msg|
        pp msg
      end
      @job.bury
    end

    def save(jid, result)
      @pool.put_result(jid, result)
      pp [@job[:pid], jid, result]
    end

  end
end