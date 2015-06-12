require 'spec_helper'

describe SpreeAutogenerateVariants::Combinator do
  let(:red)    { double(id: 1) }
  let(:blue)   { double(id: 2) }
  let(:green)  { double(id: 3) }

  let(:small)  { double(id: 4) }
  let(:medium) { double(id: 5) }
  let(:large)  { double(id: 6) }

  let(:male)   { double(id: 7) }
  let(:female) { double(id: 8) }

  let(:color) { double(option_values: [red, blue, green]) }
  let(:size) { double(option_values: [small, medium, large]) }
  let(:gender) { double(option_values: [female, male]) }

  let(:variant1) { double(option_values: [red, small, male]) }
  let(:variant2) { double(option_values: [blue, small, female]) }

  let(:product) { double(option_types: [color, size, gender], variants: [variant1, variant2]) }

  subject { described_class.new(product) }

  describe '#all' do
    it 'gets all possible combinations of option values' do
      expect(subject.all).to include('1-4-7')
      expect(subject.all).to include('1-5-7')
      expect(subject.all).to include('1-6-7')

      expect(subject.all).to include('2-4-7')
      expect(subject.all).to include('2-5-7')
      expect(subject.all).to include('2-6-7')

      expect(subject.all).to include('3-4-7')
      expect(subject.all).to include('3-5-7')
      expect(subject.all).to include('3-6-7')

      expect(subject.all).to include('1-4-8')
      expect(subject.all).to include('1-5-8')
      expect(subject.all).to include('1-6-8')

      expect(subject.all).to include('2-4-8')
      expect(subject.all).to include('2-5-8')
      expect(subject.all).to include('2-6-8')

      expect(subject.all).to include('3-4-8')
      expect(subject.all).to include('3-5-8')
      expect(subject.all).to include('3-6-8')
    end
  end

  describe '#persisted' do 
    it 'gets currently persisted combinations' do
      expect(subject.persisted).to eql(['1-4-7', '2-4-8'])
    end
  end

  describe '#not_persisted' do
    it 'gets combinations that are not persisted' do
      expect(subject.not_persisted).to include('1-5-7')
      expect(subject.not_persisted).to include('1-6-7')

      expect(subject.not_persisted).to include('2-4-7')
      expect(subject.not_persisted).to include('2-5-7')
      expect(subject.not_persisted).to include('2-6-7')

      expect(subject.not_persisted).to include('3-4-7')
      expect(subject.not_persisted).to include('3-5-7')
      expect(subject.not_persisted).to include('3-6-7')

      expect(subject.not_persisted).to include('1-4-8')
      expect(subject.not_persisted).to include('1-5-8')
      expect(subject.not_persisted).to include('1-6-8')

      expect(subject.not_persisted).to include('2-5-8')
      expect(subject.not_persisted).to include('2-6-8')

      expect(subject.not_persisted).to include('3-4-8')
      expect(subject.not_persisted).to include('3-5-8')
      expect(subject.not_persisted).to include('3-6-8')

      expect(subject.not_persisted).to_not include('1-4-7')
      expect(subject.not_persisted).to_not include('2-4-8')
    end
  end
end
