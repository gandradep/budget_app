require 'rails_helper'

RSpec.describe 'Category', type: :system do
  describe 'index' do
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
      visit categories_path
    end

    it 'renders category' do
      expect(page).to have_content(@cat1.name)
    end
    it 'renders total amount of transactions' do
      expect(page).to have_content(@tran1.amount + @tran2.amount)
    end
    it 'click category shows category page' do
      click_link @cat1.name
      expect(page).to have_current_path(category_path(@cat1))
    end
    it 'click category shows category page' do
      click_link 'Add category'
      expect(page).to have_current_path(new_category_path)
    end
    it 'click sign out goes root' do
      click_button 'Log out'
      expect(page).to have_current_path(root_path)
    end
  end
end
