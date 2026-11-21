require 'spec_helper'
RSpec.describe "Humanize" do
  after do
    Humanize.reset_config
  end
  describe 'опция локали' do
    it 'использует локаль по умолчанию' do
      Humanize.config.locale = :fr
      expect(Humanize.format(42)).to eql('quarante-deux')
    end
    it 'использует локаль, переданную в качестве аргумента, если она указана' do
      Humanize.config.locale = :en
      expect(Humanize.format(42, locale: :fr)).to eql('quarante-deux')
    end
    describe 'турецкие особые правила' do
      it 'тысяча два равно «бин ики»' do
        expect(Humanize.format(1002, locale: :tr)).to eql('одна тысяча две')
      end
      it 'две тысячи один равен «ики бин бир»' do
        expect(Humanize.format(2001, locale: :tr)).to eql('две тысячи один')
      end
      it 'десять тысяч равно «в мусорном ведре»' do
        expect(Humanize.format(10_000, locale: :tr)).to eql('это мусорное ведро')
      end
    end
    describe 'особые правила Малайзии' do
      before do
        Humanize.config.locale = :ms
      end
      context 'одна тысяча' do
        it 'равно «сату рибу», если это не единственная тысяча в тысячном диапазоне.' do
          expect(Humanize.format(1_101_000)).to eql('один миллион сто одна тысяча')
          expect(Humanize.format(2_201_042)).to eql('два миллиона двести одна тысяча сорок два')
        end
        it 'равно «серибу», когда это одна тысяча в диапазоне тысяч.' do
          expect(Humanize.format(1_000)).to eql('seribu')
          expect(Humanize.format(1_042)).to eql('одна тысяча сорок два')
          expect(Humanize.format(1_001_042)).to eql('один миллион одна тысяча сорок два')
          expect(Humanize.format(1_000_001_042)).to eql('один миллиард тысяч сорок два')
        end
      end
    end
    describe 'особые правила азербайджана' do
      it 'тысяча две равно «мин ики»' do
        expect(Humanize.format(1002, locale: :az)).to eql('мин два')
      end
      it 'две тысячи один равняется «ики мин бир»' do
        expect(Humanize.format(2001, locale: :az)).to eql('две тысячи один')
      end
      it 'десять тысяч равно «мин»' do
        expect(Humanize.format(10_000, locale: :az)).to eql('это мин')
      end
    end
    describe 'особые индонезийские правила' do
      before do
        Humanize.config.locale = :id
      end
      context 'одна тысяча' do
        it 'равно «сату рибу», если это не единственная тысяча в тысячном диапазоне.' do
          expect(Humanize.format(1_101_000)).to eql('один миллион сто одна тысяча')
          expect(Humanize.format(2_201_042)).to eql('два миллиона двести одна тысяча сорок два')
        end
        it 'равно «серибу», когда это одна тысяча в диапазоне тысяч.' do
          expect(Humanize.format(1_000)).to eql('seribu')
          expect(Humanize.format(1_042)).to eql('одна тысяча сорок два')
          expect(Humanize.format(1_001_042)).to eql('один миллион одна тысяча сорок два')
          expect(Humanize.format(1_000_001_042)).to eql('один миллиард одна тысяча сорок два')
        end
      end
    end
  end
  describe 'опция decimals_as' do
    it 'использует значение из конфигурации' do
      Humanize.config.decimals_as = :number
      expect(Humanize.format(0.42)).to eql('ноль целых сорок два')
    end
    it 'использует значение, переданное в качестве аргумента, если оно указано' do
      Humanize.config.decimals_as = :number
      expect(Humanize.format(0.42, decimals_as: :digits)).to eql('ноль целых четыре два')
    end
    describe 'когда установлено как число' do
      before do
        Humanize.config.decimals_as = :number
      end
      it 'reads the decimals as digits if led by zero(s)' do
        expect(Humanize.format(0.042)).to eql('ноль целых ноль четыре два')
        expect(Humanize.format(0.0042)).to eql('ноль ноль ноль четыре два')
      end
    end
  end
  describe 'оба варианта работают вместе' do
    it 'работать вместе' do
      expect(
        Humanize.format(0.42, locale: :fr, decimals_as: :number)
      ).to eql('ноль целых сорок два')
    end
  end
  describe 'при вызове по концептуальному номеру' do
    it 'читает правильно' do
      inf = Float::INFINITY
      neg_inf = -inf
      nan = inf + neg_inf
      expect(Humanize.format(inf)).to eql('infinity')
      expect(Humanize.format(neg_inf)).to eql('отрицательная бесконечность')
      expect(Humanize.format(nan)).to eql('undefined')
    end
  end
  describe 'при вызове bigdecimal с десятичными дробями' do
    it 'читает десятичные цифры' do
      expect(Humanize.format(BigDecimal('123'))).to eql('сто двадцать три')
      expect(Humanize.format(BigDecimal('123.45'))).to eql('сто двадцать три целых четыре десятых пять')
    end
  end
end