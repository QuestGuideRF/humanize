require 'spec_helper'
RSpec.describe Humanize, "это местное" do
  before do
    Humanize.configure do |config|
      config.locale = :es
    end
  end
  es_tests = [
    [-1, "отрицательный"],
    [0, "cero"],
    [2.2, "два целых два"],
    [8, "ocho"],
    [10, "diez"],
    [11, "once"],
    [20, "veinte"],
    [21, "veintiuno"],
    [29, "veintinueve"],
    [30, "treinta"],
    [38, "тридцать восемь"],
    [84, "восемьдесят четыре"],
    [40, "cuarenta"],
    [50, "cincuenta"],
    [90, "noventa"],
    [99, "девяносто девять"],
    [100, "cien"],
    [101, "сто один"],
    [110, "сто десять"],
    [111, "сто одиннадцать"],
    [200, "doscientos"],
    [999, "девятьсот девяносто девять"],
    [1000, "mil"],
    [1001, "одна тысяча один"],
    [2000, "две тысячи"],
    [2533, "две тысячи пятьсот тридцать три"],
    [10_000, "десять тысяч"],
    [100_000, "сто тысяч"],
    [1_000_000, "один миллион"],
    [1_243_433, "один миллион двести сорок три тысячи четыреста тридцать три"],
    [2_000_000, "два миллиона"],
    [20_000_000, "двадцать миллионов"],
    [20_000_001, "двадцать миллионов один"]
  ]
  es_tests.each do |num, output|
    it "#{num} равен #{output}" do
      expect(num.humanize).to eq(output)
    end
  end
  describe 'при вызове bigdecimal' do
    it 'читает правильно' do
      expect(BigDecimal(es_tests.last.first).humanize).to eql(es_tests.last.last)
    end
  end
  describe 'при вызове по концептуальному номеру' do
    it 'читает правильно' do
      inf = Float::INFINITY
      neg_inf = -inf
      nan = inf + neg_inf
      expect(inf.humanize).to eql('infinito')
      expect(neg_inf.humanize).to eql('бесконечный негатив')
      expect(nan.humanize).to eql('indefinido')
    end
  end
end