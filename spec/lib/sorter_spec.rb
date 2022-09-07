RSpec.describe Sorter do 
  describe '#run' do 
    subject { @sorter.run }

    before do 
      @data_rows = [
        [ 'z', 2 ],
        [ 'a', 9 ],
        [ 'm', 1 ]
      ]

      @sorter = described_class.new(
        data_rows: @data_rows,
        sort_column: sort_column,
        sort_order: sort_order
      )

      subject
    end

    context 'when by column 1 descending' do 
      let(:sort_column) { 1 }
      let(:sort_order) { 'desc' }

      it 'sorts correctly' do 
        is_expected.to eq(
          [
            [ 'a', 9 ],
            [ 'z', 2 ],
            [ 'm', 1 ]
          ]
        )
      end
    end

    context 'when by column 0 ascending' do 
      let(:sort_column) { 0 }
      let(:sort_order) { 'asc' }

      it 'sorts correctly' do 
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