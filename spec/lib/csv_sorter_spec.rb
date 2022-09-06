RSpec.describe CsvSorter do 
  describe 'CONSTANTS' do 
    describe 'COMMA_SEPARATOR' do 
      subject { described_class::COMMA_SEPARATOR }
      it { is_expected.to eq(',') }
      it { is_expected.to be_frozen }
    end
  end

  describe '#run' do 
    subject { @csv_sorter.run }

    before do 
      @args = {
        column_separator: column_separator,
        path: 'file-path',
        sort_column: sort_column
      }.compact

      @csv_sorter = described_class.new(**@args)

      @csv_double = instance_double(CSV, read: unsorted_data)
      allow(CSV).to receive(:new).and_return(@csv_double)

      allow(File).to receive(:read).and_return('data-string')

      subject
    end

    context 'when optional arguments are passed' do 
      let(:column_separator) { '|' }
      let(:sort_column) { 7 }
      
      let(:unsorted_data) do 
        [
          ['abc', '123', 'def'],
          ['ghi', '789', 'xyx'],
          ['jkl', '456', 'uvw']
        ]
      end

      it 'calls read on File with the correct argument' do 
        expect(File).to have_received(:read).with('file-path')
      end

      it 'uses the passed arguments' do 
        expect(CSV).to have_received(:new).with(
          'data-string', 
          col_sep: column_separator
        )
      end
    end

    context 'when optional arguments are not passed' do 
      let(:column_separator) { nil }
      let(:sort_column) { nil }

      let(:unsorted_data) do 
        [
          ['abc', '123', 'def'],
          ['ghi', '789', 'xyx'],
          ['jkl', '456', 'uvw']
        ]
      end

      it 'calls read on File with the correct argument' do 
        expect(File).to have_received(:read).with('file-path')
      end

      it 'uses the passed arguments' do 
        expect(CSV).to have_received(:new).with(
          'data-string', 
          col_sep: described_class::COMMA_SEPARATOR
        )
      end
    end
  end
end