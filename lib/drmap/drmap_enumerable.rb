module Enumerable

  def drmap(&block)
    raise "No data" if self.size == 0
    pool = Drmap::BeanstalkPool.new

    jid = Kernel.rand(100)
    each_with_index do |element, idx|
      # puts "Adding #{jid}, #{element}, #{block.to_ruby}"
      pool.put_job(jid, block.to_ruby, element)
    end

    results = []
    while results.size < length
      results << pool.next_result(jid)
    end
    results
  end

end