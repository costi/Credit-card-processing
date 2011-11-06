RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true
  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
  # ctrl+c in autotest to run the migrations again
  config.before(:suite) { DataMapper.auto_migrate! }

end
