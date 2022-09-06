RSpec.describe SortingHat do 
  describe 'CONSTANTS' do 
    describe 'DEFAULT_SORT_COLUMN' do 
      subject { described_class::DEFAULT_SORT_COLUMN }
      it { is_expected.to eq(0) }
    end
    describe 'DEFAULT_SORT_ORDER' do 
      subject { described_class::DEFAULT_SORT_ORDER }
      it { is_expected.to eq('asc') }
      it { is_expected.to be_frozen }
    end
  end

  describe '#run' do 
    subject { @sorting_hat.run }

    before do 
      @kargs = {
        path: 'file-path',
        sort_column: sort_column,
        sort_order: sort_order
      }.compact

      @sorting_hat = described_class.new(**@kargs)

      @reader = instance_double(Reader, run: 'data-rows')
      allow(Reader).to receive(:new).and_return(@reader)

      @sorter = instance_double(Sorter, run: 'sorted-data')
      allow(Sorter).to receive(:new).and_return(@sorter) 

      subject
    end

    context 'when all arguments are passed' do 
      let(:sort_column) { 1 }
      let(:sort_order) { 'desc' }

      it { is_expected.to eq('sorted-data') }

      it 'instantiates and calls the reader correctly' do 
        expect(Reader).to have_received(:new).with(path: 'file-path')
        expect(@reader).to have_received(:run)
      end

      it 'instantiates and calls the sorter correctly' do 
        expect(Sorter).to have_received(:new).with(
          data_rows: 'data-rows',
          sort_column: sort_column,
          sort_order: sort_order
        )
        expect(@sorter).to have_received(:run)
      end
    end

    context 'when only required arguments are passed' do 
      let(:sort_column) { nil }
      let(:sort_order) { nil }

      it { is_expected.to eq('sorted-data') }

      it 'instantiates and calls the reader correctly' do 
        expect(Reader).to have_received(:new).with(path: 'file-path')
        expect(@reader).to have_received(:run)
      end

      it 'instantiates and calls the sorter correctly' do 
        expect(Sorter).to have_received(:new).with(
          data_rows: 'data-rows',
          sort_column: described_class::DEFAULT_SORT_COLUMN,
          sort_order: described_class::DEFAULT_SORT_ORDER
        )
        expect(@sorter).to have_received(:run)
      end
    end
  end
end