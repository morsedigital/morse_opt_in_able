module OptInAble 
  extend ActiveSupport::Concern
  include FieldsValidator

  included do
    validate_required_attributes
  end

  class_methods do
    def required_attributes
      result=defined?(super) ? super : []
      result+=required_opt_in_able_attributes
    end

    def required_database_fields
      result=defined?(super) ? super : []
      result+=[:allow_email, :allow_sms, :allow_phone, :allow_mail, :optin_marketing, :optin_third_party]
    end

    def required_opt_in_able_attributes
      [:allow_email, :allow_sms, :allow_phone, :allow_mail, :optin_marketing, :optin_third_party]
    end
  end

  public

  private


end

