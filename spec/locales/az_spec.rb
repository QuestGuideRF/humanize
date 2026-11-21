require 'spec_helper'
RSpec.describe Humanize, "местный штат Аризона" do
  before do
    Humanize.configure do |config|
      config.locale = :az
    end
  end
  tests = [
    [8.15, 'восемь запятая один пять'],
    [1002, 'мин два'],
    [2001, 'две тысячи один'],
    [10_000, 'это мин']
  ]
  tests.each do |num, output|
    it "#{num} равно #{output}" do
      expect(num.humanize).to eql(output)
    end
  end
  context 'десятичные дроби: число' do
    it 'возвращает десятичные дроби как целые числа' do
      num = 8.15
      expect(num.humanize(decimals_as: :number)).to eq('восемь целых пятнадцать')
    end
  end
  describe 'при вызове по концептуальному номеру' do
    it 'читает правильно' do
      inf = Float::INFINITY
      neg_inf = -inf
      nan = inf + neg_inf
      expect(inf.humanize).to eql('sonsuz')
      expect(neg_inf.humanize).to eql('отрицательная бесконечность')
      expect(nan.humanize).to eql('undefined')
    end
  end
end