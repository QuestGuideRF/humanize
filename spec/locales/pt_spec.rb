require 'spec_helper'
RSpec.describe Humanize, "пт локаль" do
  before do
    Humanize.configure do |config|
      config.locale = :pt
    end
  end
  tests = [
    [8.15, 'восемь целых один пять'],
    [1000, 'mil'],
    [1002, 'одна тысяча две'],
    [2000, 'две тысячи'],
    [2002, 'две тысячи два'],
    [10_000, 'десять тысяч']
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
      expect(inf.humanize).to eql('infinito')
      expect(neg_inf.humanize).to eql('бесконечный негатив')
      expect(nan.humanize).to eql('indefinido')
    end
  end
end