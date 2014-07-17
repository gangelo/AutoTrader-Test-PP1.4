require_relative 'spec_helper'

describe 'App Class Tests:' do

  context 'Single-word sentences' do
    it 'should return [S3h], given [Smooth]' do
      it = AutoTrader::App.new 'Smooth'
      expect(it.run).to eq('S3h')
    end

    it 'should return [A2D], given [AbbbcccD]' do
      it = AutoTrader::App.new 'AbbbcccD'
      expect(it.run).to eq('A2D')
    end

    it 'should return [A2D], given [AbcbcbcD]' do
      it = AutoTrader::App.new 'AbcbcbcD'
      expect(it.run).to eq('A2D')
    end

    it 'should return [a0a], given [a]' do
      it = AutoTrader::App.new 'a'
      expect(it.run).to eq('a0a')
    end

    it 'should return [a0b], given [ab]' do
      it = AutoTrader::App.new 'ab'
      expect(it.run).to eq('a0b')
    end

    it 'should return [_z0z?,#?], given [_z?,#?]' do
      it = AutoTrader::App.new '_z?,#?'
      expect(it.run).to eq('_z0z?,#?')
    end

    it 'should return [9a1c], given [9abbbc]' do
      it = AutoTrader::App.new '9abbbc'
      expect(it.run).to eq('9a1c')
    end

    it 'should return [a0a1c0c], given [a1c]' do
      it = AutoTrader::App.new 'a1c'
      expect(it.run).to eq('a0a1c0c')
    end

    it 'should return [a0c2], given [ac2]' do
      it = AutoTrader::App.new 'ac2'
      expect(it.run).to eq('a0c2')
    end
  end

  context 'Multi-word sentences' do
    it 'should return [T2s i0s t1o#w3s], given [This is two#words]' do
      it = AutoTrader::App.new 'This is two#words'
      expect(it.run).to eq('T2s i0s t1o#w3s')
    end

    it 'should retain spaces and return [   3L5g     5e4d a1d 10t5g          ], given [   3Leading     5embedded and 10trailing          ]' do
      it = AutoTrader::App.new '   3Leading     5embedded and 10trailing          '
      result = it.run
      puts "'#{result}'"
      expect(result).to eq('   3L5g     5e4d a1d 10t5g          ')
    end

    it 'should retain spaces/non-alphabetic chars and return [   3L5g     5e4d a1d 10t5g          ], given [   3Leading     5embedded, and, 10trailing          ]' do
      it = AutoTrader::App.new '   3Leading     5embedded, and, 10trailing          '
      expect(it.run).to eq('   3L5g     5e4d, a1d, 10t5g          ')
    end
  end
end
