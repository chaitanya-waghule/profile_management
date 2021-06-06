RSpec.describe AdminUser do

  let(:admin_user) { build(:admin_user) }

  describe '.default_scope' do

    it do
      expect(described_class.all.where_values_hash.transform_keys(&:to_sym)).to eq(admin: true)
    end

  end

  describe 'Validations' do

    subject { admin_user }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:middle_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_length_of(:email).is_at_least(6).is_at_most(25) }
    it { is_expected.to validate_length_of(:first_name).is_at_least(2).is_at_most(15) }
    it { is_expected.to validate_length_of(:middle_name).is_at_least(2).is_at_most(15) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(2).is_at_most(15) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to allow_value('admin_john@example.com').for(:email) }
    it { is_expected.to allow_value('John').for(:first_name) }
    it { is_expected.to allow_value('Harry').for(:middle_name) }
    it { is_expected.to allow_value('Hawkins').for(:last_name) }

  end

  describe 'Callbacks' do

    describe '#before_save' do

      context 'when email is provided in mixed' do

        before do
          admin_user.email = 'JOHN@EXAMPLE.com'
          admin_user.save
        end

        it 'converts email to downcase' do
          expect(admin_user.email).to eq('john@example.com')
        end

      end

    end

  end

  describe 'Associations' do

    it { is_expected.to have_one(:address) }
    it { is_expected.to have_one_attached(:profile_picture) }
    it { is_expected.to have_secure_password }

  end

  describe 'Instance Method' do

    describe '#full_name' do

      it 'returns full_name of admin_user' do
        expect(admin_user.full_name).to eq('John Harry Hawkins')
      end

    end

    describe '#attached_profile_picture' do

      context 'when profile picture is attached' do

        before do
          admin_user.profile_picture.attach(
            io: File.open("#{Rails.root}/app/assets/images/default_profile_picture.png"),
            filename: 'default_profile_picture.png'
          )
        end

        it 'return profile picture' do
          expect(admin_user.attached_profile_picture).to be_a(ActiveStorage::Attached::One)
        end

      end

      context 'when profile picture is not attached' do

        it 'returns path to default profile picture image' do
          expect(admin_user.attached_profile_picture).to eq('/assets/default_profile_picture.png')
        end

      end

    end

  end

end
