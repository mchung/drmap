$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'pp'

require 'beanstalk-client'
require 'ruby2ruby'

require 'drmap/drmap_enumerable'
require 'drmap/beanstalk_worker'
require 'drmap/beanstalk_pool'
require 'drmap/version'

module Drmap
  VERSION = Drmap::Version::STRING
end