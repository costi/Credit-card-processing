#!/usr/bin/env ruby
CC_ENV='development'
require File.join(File.dirname(__FILE__), 'environment')

DataMapper.auto_migrate!
