require 'rubygems'
require 'drmap'

addresses = ["baz@example.com", "foo@example.com", "bar@example.com"]
addresses.drmap do |email|
  puts "You are now emailing: #{email}"
end
