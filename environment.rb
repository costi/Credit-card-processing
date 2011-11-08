require 'rubygems'
require 'data_mapper'
require 'pry'
Root = File.dirname(__FILE__)

DataMapper::Logger.new('tmp/test.log', :debug)
#DataMapper.setup(:default, 'sqlite::memory:')
if CC_ENV=='development'
  DataMapper.setup(:default, "sqlite://#{Root}/tmp/credit_card_processing_development.db")
else
  DataMapper.setup(:default, "sqlite://#{Root}/tmp/credit_card_processing_test.db")
end

require File.join(Root, 'credit_card')
require File.join(Root, 'transaction')
require File.join(Root, 'transaction', 'charge')
require File.join(Root, 'transaction', 'credit')
require File.join(Root, 'util', 'infinity')
require File.join(Root, 'batch')
DataMapper.finalize
