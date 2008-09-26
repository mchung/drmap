# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/drmap.rb'

Hoe.new('drmap', Drmap::VERSION) do |p|
  p.rubyforge_name = 'drmap'
  p.developer('Marc Chung', 'marc.chung@openrain.com')
end

Dir['tasks/**/*.rake'].each { |rake| load rake }

# vim: syntax=Ruby
