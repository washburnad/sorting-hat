RSpec.describe Sorter do 
  describe '#run' do 
    subject { @sorter.run }

    before do 
      @data_rows = [
        [ 'z', 2 ],
        [ 'a', 9 ],
        [ 'm', 1 ]
      ]

      @kargs = {
        data_rows: @data_rows,
        sort_column: sort_column,
        sort_order: sort_order
      }.compact

      @sorter = described_class.new(**@kargs)

      subject
    end

    context 'when all arguments are passed' do 
      let(:sort_column) { 1 }
      let(:sort_order) { 'desc' }

      it 'sorts by column 1 descending' do 
        is_expected.to eq(
          [
            [ 'a', 9 ],
            [ 'z', 2 ],
            [ 'm', 1 ]
          ]
        )
      end
    end

    context 'when only required arguments are passed' do 
      let(:sort_column) { nil }
      let(:sort_order) { nil }

      it 'sorts by column 0 ascending' do 
        is_expected.to eq(
          [
            [ 'a', 9 ],
            [ 'm', 1 ],
            [ 'z', 2 ]
          ]
        )
      end
    end
  end
end