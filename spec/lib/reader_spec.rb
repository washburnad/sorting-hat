RSpec.describe Reader do 
  describe 'CONSTANTS' do 
    describe 'COMMA_SEPARATOR' do 
      subject { described_class::COMMA_SEPARATOR }
      it { is_expected.to eq(',') }
      it { is_expected.to be_frozen }
    end
  end

  describe '#run' do 
    subject { @reader.run }

    before do 
      @kargs = {
        column_separator: column_separator,
        path: 'file-path'
      }.compact

      @reader = described_class.new(**@kargs)

      @csv_double = instance_double(CSV, read: 'unsorted-data')
      allow(CSV).to receive(:new).and_return(@csv_double)

      allow(File).to receive(:read).and_return('data-string')

      subject
    end

    context 'when all arguments are passed' do 
      let(:column_separator) { '|' }

      it { is_expected.to eq('unsorted-data') }

      it 'calls read on File with the correct argument' do 
        expect(File).to have_received(:read).with('file-path')
      end

      it 'calls CSV with the passed arguments' do 
        expect(CSV).to have_received(:new).with(
          'data-string', 
          col_sep: column_separator
        )
      end
    end

    context 'when only required arguments are passed' do 
      let(:column_separator) { nil }

      it { is_expected.to eq('unsorted-data') }

      it 'calls read on File with the correct argument' do 
        expect(File).to have_received(:read).with('file-path')
      end

      it 'calls CSV the passed and default arguments' do 
        expect(CSV).to have_received(:new).with(
          'data-string', 
          col_sep: described_class::COMMA_SEPARATOR
        )
      end
    end
  end
end