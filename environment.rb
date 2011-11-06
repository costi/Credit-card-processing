require 'rubygems'
require 'data_mapper'
Root = File.dirname(__FILE__)
require File.join(Root, 'credit_card')
require File.join(Root, 'transaction')
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite::memory:')
#DataMapper.setup(:default, 'sqlite:///path/to/project.db')

