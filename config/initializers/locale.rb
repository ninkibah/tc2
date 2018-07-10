# config/initializers/locale.rb

# Where the I18n library should search for translation files
I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]

# Whitelist locales available for the application
I18n.available_locales = [:en, :de]

# Set default locale to something other than :en
I18n.default_locale = :de

require 'active_model'

module CommaAsDecimalSeparator
  def cast_value(value)
    separator = I18n::t('number.format.separator')
    delimiter = I18n::t('number.format.delimiter')
    if value.is_a?(String)
      value = value.gsub(delimiter, '')
      value = value.gsub(separator, '.').to_d
    end
    super(value)
  end
end

ActiveModel::Type::Decimal.send(:prepend, CommaAsDecimalSeparator)
