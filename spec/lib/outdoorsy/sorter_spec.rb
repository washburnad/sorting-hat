require 'pry'; binding.pry

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
end