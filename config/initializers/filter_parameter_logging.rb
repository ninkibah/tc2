# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]

# We don't want colorized log files. They are just confusing in other tools
Rails.application.config.colorize_logging = false
