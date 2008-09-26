module Enumerable

  def drmap(&block)
    pool = Drmap::BeanstalkPool.new

    jid = rand(100)
    each_with_index do |element, idx|
      pool.put_job(jid, block.to_ruby, element)
    end

    results = []
    while results.size < length
      results << pool.next_result(jid)
    end
    results
  end

end