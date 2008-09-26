module Drmap
  class BeanstalkPool

    # Worst design ever!
    def self.hosts=(bean_hosts)
      @@hosts = bean_hosts
    end

    def initialize
      @pool = Beanstalk::Pool.new(@@hosts)
    end

    def peers
      @pool
    end

    def next_job
      watch_jobs
      @pool.reserve
    end

    def put_job(jid, proc_str, data)
      @pool.use("job")
      payload = {:pid => Process.pid, :jid => jid, :proc => proc_str, :data => data}
      @pool.yput(payload)
    end

    def next_result(jid)
      watch_results(jid)
      job = @pool.reserve
      job_payload = job.ybody[:result]
    end

    def put_result(jid, result)
      @pool.use("result#{jid}")
      payload = {:pid => Process.pid, :jid => jid, :result => result}
      @pool.yput(payload)
    end

    def watch_jobs
      @pool.watch("job")
      @pool.ignore("default")
    end

    def watch_results(jid)
      @pool.watch("result#{jid}")
      @pool.ignore("default")
      @pool.ignore("job")
    end

  end
end
