require File.dirname(__FILE__) + '/spec_helper'

describe "Drmap" do

  it "should distribute tasks" do
    addresses = ["baz@example.com", "foo@example.com", "bar@example.com"]
    addresses.drmap do |email|
      puts "You are now emailing: #{email}"
    end
  end

end
