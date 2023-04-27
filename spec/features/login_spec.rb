require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  scenario "Create a new user by quick input" do
    visit '/'
    fill_in 'Username', with: 'mint'
    fill_in 'Password', with: 'password'
    click_on 'Login/Registry'
    assert_text 'Create account and sign in successfully.'
  end

  context 'User have account' do
    before(:each) do
      user = User.create(username: 'min', password: 'password')
    end

    scenario 'Login with correct password' do
      visit '/'
      fill_in 'Username', with: 'min'
      fill_in 'Password', with: 'password'
      click_on 'Login/Registry'
      assert_text 'Sign in successfully.'
    end

    scenario 'Login with wrong password' do
      visit '/'
      fill_in 'Username', with: 'min'
      fill_in 'Password', with: 'wrongpassword'
      click_on 'Login/Registry'
      assert_text 'Wrong password.'
    end
  end
end
