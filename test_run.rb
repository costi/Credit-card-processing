#!/usr/bin/env ruby
CC_ENV='test'
require File.join(File.dirname(__FILE__), 'environment')
DataMapper.auto_migrate! 
batch = Batch.new(File.open(File.join(Root, 'test_input.txt')))
batch.process_file
batch.print_summary
