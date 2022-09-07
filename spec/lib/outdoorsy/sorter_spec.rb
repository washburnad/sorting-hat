RSpec.describe Outdoorsy::Sorter do 
  # Constants
  describe 'COMMA_DELIMITER' do 
    subject { described_class::COMMA_DELIMITER }
    it { is_expected.to eq(',') }
    it { is_expected.to be_frozen }
  end

  describe 'COMMA_REGEX' do 
    subject { described_class::COMMA_REGEX }
    it { is_expected.to eq(/\A.*(,.*){5}$/) }
  end

  describe 'PIPE_DELIMITER' do 
    subject { described_class::PIPE_DELIMITER }
    it { is_expected.to eq('|') }
    it { is_expected.to be_frozen }
  end

  describe 'PIPE_REGEX' do 
    subject { described_class::PIPE_REGEX }
    it { is_expected.to eq(/\A.*(\|.*){5}$/) }
  end

  describe 'HEADERS' do 
    subject { described_class::HEADERS }

    it do 
      is_expected.to eq(
        %i(
          first_name 
          last_name 
          email
          vehicle_type
          vehicle_name
          vehicle_length
        )
      )
    end

    it { is_expected.to be_frozen }
  end

  describe '#sort' do 
    context 'when correctly formatted' do 
      subject { @sorter.sort(**@kargs) }

      before do 
        @logger = instance_double(Logger, info: true)
        allow(Logger).to receive(:new).and_return(@logger)

        @sorter = described_class.new(path: path)

        @kargs = {
          sort_column: sort_column,
          sort_order: sort_order
        }.compact 

        subject
      end

      context 'when comma separated' do 
        let(:path) { 'spec/fixtures/commas.txt' }

        context 'with default sorting' do 
          let(:sort_column) { nil }
          let(:sort_order) { nil }

          it 'logs the rows in the correct order' do 
            expect(@logger).to have_received(:info).with(/Greta Thunberg/).ordered
            expect(@logger).to have_received(:info).with(/Jimmy Buffet/).ordered
            expect(@logger).to have_received(:info).with(/Mandip Singh Soin/).ordered
            expect(@logger).to have_received(:info).with(/Xiuhtezcatl Martinez/).ordered
          end
        end

        context 'with non-default sorting' do 
          let(:sort_column) { :last_name }
          let(:sort_order) { :desc }

          it 'logs the rows in the correct order' do 
            expect(@logger).to have_received(:info).with(/Thunberg/).ordered
            expect(@logger).to have_received(:info).with(/Singh Soin/).ordered
            expect(@logger).to have_received(:info).with(/Martinez/).ordered
            expect(@logger).to have_received(:info).with(/Buffet/).ordered
          end
        end
      end

      context 'when pipes separated' do 
        let(:path) { 'spec/fixtures/pipes.txt' }

        context 'with default sorting' do 
          let(:sort_column) { nil }
          let(:sort_order) { nil }

          it 'logs the rows in the correct order' do 
            expect(@logger).to have_received(:info).with(/Ansel Adams/).ordered
            expect(@logger).to have_received(:info).with(/Isatou Ceesay/).ordered
            expect(@logger).to have_received(:info).with(/Naomi Uemura/).ordered
            expect(@logger).to have_received(:info).with(/Steve Irwin/).ordered
          end
        end

        context 'with non-default sorting' do 
          let(:sort_column) { :vehicle_type }
          let(:sort_order) { :asc }

          it 'logs the rows in the correct order' do 
            expect(@logger).to have_received(:info).with(/bicycle/).ordered
            expect(@logger).to have_received(:info).with(/campervan/).ordered
            expect(@logger).to have_received(:info).with(/motorboat/).ordered
            expect(@logger).to have_received(:info).with(/RV/).ordered
          end
        end
      end
    end

    context 'when incorrectly formatted' do 
      subject { described_class.new(path: path) }

      context 'when hyphen separated' do 
        let(:path) { 'spec/fixtures/hyphens.txt' }

        it 'raises a malformed CSV error' do 
          expect { subject }.to raise_error(
            CSV::MalformedCSVError, 
            'File is not in expected Outdoorsy format in line 1.'
          )
        end
      end
      
      context 'with a missing column' do 
        let(:path) { 'spec/fixtures/missing_column.txt' }

        it 'raises a malformed CSV error' do 
          expect { subject }.to raise_error(
            CSV::MalformedCSVError, 
            'File is not in expected Outdoorsy format in line 1.'
          )
        end
      end
    end
  end
end