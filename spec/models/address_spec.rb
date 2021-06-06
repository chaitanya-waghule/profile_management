RSpec.describe Address do

  let(:address) { build(:address) }

  describe 'Validations' do

    subject { address }

    it { is_expected.to validate_presence_of(:address_line) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:landmark) }
    it { is_expected.to validate_presence_of(:mobile_number) }
    it { is_expected.to validate_presence_of(:province) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_length_of(:address_line).is_at_least(2).is_at_most(20) }
    it { is_expected.to validate_length_of(:city).is_at_least(2).is_at_most(20) }
    it { is_expected.to validate_length_of(:landmark).is_at_least(2).is_at_most(20) }
    it { is_expected.to validate_length_of(:province).is_at_least(2).is_at_most(20) }
    it { is_expected.to validate_length_of(:street).is_at_least(2).is_at_most(20) }
    it { is_expected.to validate_length_of(:mobile_number).is_equal_to(10) }
    it { is_expected.to validate_uniqueness_of(:mobile_number).case_insensitive }
    it { is_expected.to allow_value('301 B wing').for(:address_line) }
    it { is_expected.to allow_value('Mumbai').for(:city) }
    it { is_expected.to allow_value('Statue of liberty').for(:landmark) }
    it { is_expected.to allow_value('9876543210').for(:mobile_number) }
    it { is_expected.to allow_value('Maharashtra').for(:province) }
    it { is_expected.to allow_value('Baker Street').for(:street) }
    it { is_expected.to allow_value('123456').for(:zip) }

  end

  describe 'Associations' do

    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to belong_to(:admin_user).optional }

  end

end
