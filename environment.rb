require 'rubygems'
require 'data_mapper'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite::memory:')
#DataMapper.setup(:default, 'sqlite:///path/to/project.db')

