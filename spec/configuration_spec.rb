require 'spec_helper'
module Humanize
  describe Configuration do
    after(:each) do
      Humanize.reset_config
    end
    describe "#default_locale (устарело)" do
      it "значение по умолчанию: ru" do
        expect(Humanize.config.default_locale).to eq(:en)
      end
      it "значение можно изменить с помощью блока" do
        Humanize.configure do |config|
          config.locale = :fr
        end
        expect(Humanize.config.default_locale).to eq(:fr)
        expect(Humanize.config.locale).to eq(:fr)
      end
      it "значение можно изменить напрямую" do
        Humanize.config.locale = :fr
        expect(Humanize.config.default_locale).to eq(:fr)
        expect(Humanize.config.locale).to eq(:fr)
      end
    end
    describe "#локаль" do
      it "значение по умолчанию: ru" do
        expect(Humanize.config.locale).to eq(:en)
      end
      it "значение можно изменить с помощью блока" do
        Humanize.configure do |config|
          config.locale = :fr
        end
        expect(Humanize.config.locale).to eq(:fr)
      end
      it "значение можно изменить напрямую" do
        Humanize.config.locale = :fr
        expect(Humanize.config.locale).to eq(:fr)
      end
    end
  end
end