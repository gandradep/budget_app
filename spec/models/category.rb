require 'rails_helper'

RSpec.describe Category, type: :model do
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
  context 'Category model validation' do
    it 'name should be present' do
      @cat1.name = nil
      expect(@cat1).to_not be_valid
    end

    it 'name shouldnt be blank' do
      @cat1.name = ''
      expect(@cat1).to_not be_valid
    end

    it 'icon_url should be present' do
      @cat1.icon_url = nil
      expect(@cat1).to_not be_valid
    end

    it 'icon_url shouldnt be blank' do
      @cat1.icon_url = ''
      expect(@cat1).to_not be_valid
    end

    it 'category has user' do
      expect(@cat1.author).to eq(@user)
    end

    it 'category has transaction' do
      expect(@cat1.transacctions).to include(@tran1)
    end
  end
end
