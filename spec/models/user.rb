require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.create(
      name: 'Gabriel',
      email: 'test@mail.com',
      password: 'testpass',
      confirmed_at: Time.now.utc
    )
  end
  context 'User model validation' do
    it 'name should be present' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'name shouldnt be blank' do
      @user.name = ''
      expect(@user).to_not be_valid
    end
  end
end
