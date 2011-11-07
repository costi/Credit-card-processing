require 'rubygems'
require 'data_mapper'
require 'pry'
Root = File.dirname(__FILE__)

DataMapper::Logger.new($stdout, :debug)
#DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.setup(:default, "sqlite://#{Root}/tmp/credit_card_processing.db")

require File.join(Root, 'credit_card')
require File.join(Root, 'transaction')
require File.join(Root, 'transaction', 'charge')
require File.join(Root, 'transaction', 'credit')
require File.join(Root, 'util', 'infinity')
DataMapper.finalize
