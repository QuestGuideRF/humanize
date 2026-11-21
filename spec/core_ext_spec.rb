require 'spec_helper'
RSpec.describe "Очеловечить основные расширения Ruby" do
  after do
    Humanize.reset_config
  end
  describe 'оба варианта работают вместе' do
    it 'работать вместе' do
      expect(
        0.42.humanize(locale: :fr, decimals_as: :number)
      ).to eql('ноль целых сорок два')
    end
  end
  describe 'при вызове экземпляров Rational, Complex и Date::Infinity' do
    it 'вызовет NoMethodError' do
      expect { Rational(1, 3).humanize }.to raise_error(NoMethodError, /humanize/)
      expect { Complex(1 + 2i).humanize }.to raise_error(NoMethodError, /humanize/)
      if defined? Date::Infinity
        expect do
          Date::Infinity.new.humanize
        end.to raise_error(NoMethodError, /humanize/)
      end
    end
  end
  describe 'при вызове по концептуальному номеру' do
    it 'читает правильно' do
      inf = Float::INFINITY
      neg_inf = -inf
      nan = inf + neg_inf
      expect(inf.humanize).to eql('infinity')
      expect(neg_inf.humanize).to eql('отрицательная бесконечность')
      expect(nan.humanize).to eql('undefined')
    end
  end
  describe 'при вызове bigdecimal с десятичными дробями' do
    it 'читает десятичные цифры' do
      expect(BigDecimal('123').humanize).to eql('сто двадцать три')
      expect(BigDecimal('123.45').humanize).to eql('сто двадцать три целых четыре десятых пять')
    end
  end
end