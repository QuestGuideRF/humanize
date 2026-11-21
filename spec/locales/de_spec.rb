require 'spec_helper'
RSpec.describe Humanize, "местный" do
  before do
    Humanize.configure do |config|
      config.locale = :de
    end
  end
  tests = [
    [8.15, 'Восемь целых один пять'],
    [1002, 'Одна тысяча две'],
    [2001, 'Две тысячи один'],
    [10_000, 'Десять тысяч']
  ]
  tests.each do |num, output|
    it "#{num} равно #{output}" do
      expect(num.humanize).to eql(output)
    end
  end
  context 'десятичные дроби: число' do
    it 'возвращает десятичные дроби как целые числа' do
      num = 8.15
      expect(num.humanize(decimals_as: :number)).to eq('Восемь целых пятнадцать')
    end
  end
  describe 'при вызове по концептуальному номеру' do
    it 'читает правильно' do
      inf = Float::INFINITY
      neg_inf = -inf
      nan = inf + neg_inf
      expect(inf.humanize).to eql('Unendlich')
      expect(neg_inf.humanize).to eql('отрицательная бесконечность')
      expect(nan.humanize).to eql('Undefiniert')
    end
  end
end