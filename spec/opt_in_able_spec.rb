require 'spec_helper'

RSpec.describe OptInAble, type: :module do

  class Thing < OpenStruct 
    include ActiveModel::Validations
    def initialize(*args)
      super
    end
    def self.column_names; [] end
    def errors_add(sym,text); @errors[sym]=text; end
  end

  class ThingWithNoFields < Thing 
    include OptInAble
  end

  class ThingWithAllowEmailOnly < Thing
    include OptInAble
    def self.column_names
      %w{allow_email}
    end
  end
  class ThingWithAllowEmailOnlyValid < Thing
    def self.required_database_fields
      [:allow_email]
    end
    def self.required_opt_in_able_attributes
      [:allow_email]
    end
    include OptInAble
    def self.column_names
      %w{allow_email}
    end
  end
  class ThingWithAllFields < Thing
    include OptInAble
    def self.column_names
      %w{allow_email allow_sms allow_phone allow_mail optin_marketing optin_third_party} 
    end
  end

  let(:thing){ThingWithAllFields.new(firstname: firstname,lastname: lastname)}

  describe "validations" do
    context "where the includer has all fields" do
      context "where all the values are present" do
        let(:thing){ThingWithAllFields.new(allow_email: true, allow_sms: true, allow_phone: true, allow_mail: true, optin_marketing: true, optin_third_party: true, do_not_contact: false)}
        it "should be_valid", focus: true do
          expect(thing.errors.size).to eq(0)
        end
      end
      context "where a field is missing" do
        context "where required_database_fields are default" do
          let(:thing){ThingWithAllowEmailOnly.new(allow_email: true)}
          it "should not be_valid" do
            thing.valid?
            expect(thing.errors.size>0).to be_truthy
          end
        end
        context "where required_database_fields are bespoke" do
          let(:thing){ThingWithAllowEmailOnlyValid.new(allow_email: true)}
          it "should be_valid" do
            thing.valid?
            expect(thing.errors.size).to eq(0)
          end
        end
      end
      context "where a value is missing" do
        let(:thing){ThingWithAllFields.new(allow_sms: true, allow_phone: true, allow_mail: true, optin_marketing: true, optin_third_party: true, do_not_contact: false)}
        it "should not be_valid" do
          thing.valid?
          expect(thing.errors.size>0).to be_truthy
        end
      end
    end
  end

  describe "instance functions" do

  end

end
