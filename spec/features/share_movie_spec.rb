require 'rails_helper'

RSpec.feature "ShareMovies", type: :feature do
  before(:each) do
    user = User.create(username: 'min', password: 'password')
    visit '/'
    fill_in 'Username', with: 'min'
    fill_in 'Password', with: 'password'
    click_on 'Login/Registry'
    click_on 'Share a movie'
    assert_selector('input#movie_link')
  end

  scenario 'Share a correct Youtube URL' do
    find('input#movie_link').set('https://www.youtube.com/watch?v=KAYxwOAo_yg')
    click_on 'Share'
    assert_text 'Your movie will be publish if available'
    movie = Movie.find_by_link('https://www.youtube.com/watch?v=KAYxwOAo_yg')
    UpdateMovieDetailsJob.perform_sync(movie.id) if movie.present?
    visit('/')
    assert_text 'The Monkey King 1: Tôn Ngộ Không Đại Náo Thiên Cung'
  end

  context 'Share a incorrect URL:' do
    scenario 'not Youtube provider' do
      find('input#movie_link').set('https://d.tube/#!/v/leohanley07/Qmd1Exd8sGb9gpTU4j7aiFDweEBbTBtMQHUPrDbCXeyLXj')
      click_on 'Share'
      assert_text 'Link is not Youtube URL.'
    end

    scenario 'not a link' do
      find('input#movie_link').set('Just a text')
      click_on 'Share'
      assert_text 'Link is not Youtube URL.'
    end
  end
end
