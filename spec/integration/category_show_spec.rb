require 'rails_helper'

RSpec.describe 'Category', type: :system do
  describe 'show' do
    before(:example) do
      @user = User.create(
        name: 'Gabriel',
        email: 'test@mail.com',
        password: 'testpass',
        confirmed_at: Time.now.utc
      )
      @cat1 = Category.create(
        author_id: @user.id,
        name: 'sports',
        icon_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/220px-Image_created_with_a_mobile_phone.png'
      )
      @tran1 = Transacction.create(
        author: @user,
        name: 'Water bottle',
        amount: 10,
        category_ids: @cat1.id
      )
      @tran2 = Transacction.create(
        author: @user,
        name: 'Water bottle',
        amount: 20,
        category_ids: @cat1.id
      )
      sign_in @user
      visit category_path(@cat1)
    end

    it 'renders category' do
      expect(page).to have_content(@cat1.name)
    end
    it 'renders total amount of transactions' do
      expect(page).to have_content(@cat1.transacctions.sum(:amount))
    end
    it 'You can find all transacctions name and amount' do
      expect(page).to have_content(@tran1.name)
      expect(page).to have_content(@tran2.name)
      expect(page).to have_content(@tran1.amount)
      expect(page).to have_content(@tran2.amount)
    end
    it 'click category shows category page' do
      click_link 'Add transaction'
      expect(page).to have_current_path(new_category_transacction_path(@cat1))
    end
  end
end
