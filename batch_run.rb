#!/usr/bin/env ruby
CC_ENV='development'
require File.join(File.dirname(__FILE__), 'environment')

DataMapper.auto_upgrade!
batch = Batch.new(ARGF) #Nifty perl-ish ARGF
batch.process_file
batch.print_summary
