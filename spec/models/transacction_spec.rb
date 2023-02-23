require 'rails_helper'

RSpec.describe Transacction, type: :model do
  before :each do
    @user = User.create(
      name: 'Gabriel',
      email: 'test@mail.com',
      password: 'testpass',
      confirmed_at: Time.now.utc
    )
    @cat1 = Category.create(
      author_id: @user.id,
      name: 'sports',
      icon_url: 'www.picture.com'
    )
    @tran1 = Transacction.create(
      author: @user,
      name: 'Water bottle',
      amount: 10,
      category_ids: @cat1.id
    )
  end
  context 'Transaction model validation' do
    it 'name should be present' do
      @tran1.name = nil
      expect(@tran1).to_not be_valid
    end

    it 'name shouldnt be blank' do
      @tran1.name = ''
      expect(@tran1).to_not be_valid
    end

    it 'amount should be present' do
      @tran1.amount = nil
      expect(@tran1).to_not be_valid
    end

    it 'amount shouldnt be blank' do
      @tran1.amount = ''
      expect(@tran1).to_not be_valid
    end

    it 'transaction has user' do
      expect(@tran1.author).to eq(@user)
    end

    it 'category has transaction' do
      expect(@tran1.categories).to include(@cat1)
    end
  end
end
