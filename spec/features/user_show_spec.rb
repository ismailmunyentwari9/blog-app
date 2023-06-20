# spec/request/user_show_spec.rb
require 'rails_helper'
require 'capybara'

RSpec.describe 'User Show Page', type: :feature do
  before do
    @user = User.create!(name: 'Test User', photo: 'https://example.com/profile.jpg', bio: 'Test bio', posts_counter: 3)
    @post1 = @user.posts.create!(title: 'Post 1', text: 'Text for Post 1')
    @post2 = @user.posts.create!(title: 'Post 2', text: 'Text for Post 2')
    @post3 = @user.posts.create!(title: 'Post 3', text: 'Text for Post 3')
    visit user_path(@user)
  end

  it "displays the user's profile picture" do
    expect(page).to have_css('img')
  end

  it "displays the user's username" do
    expect(page).to have_content('Test User')
  end

  it 'displays the number of posts the user has written' do
    visit user_path(@user.id)
    expect(page).to have_content(@user.posts.count)
  end

  it "displays the user's bio" do
    expect(page).to have_content('Test bio')
  end

  it "displays the user's first 3 posts" do
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
  end

  it "I can see a button that lets me view all of a user's posts." do
    expect(page).to have_button('See All Posts')
  end

  it "redirects to the clicked post's show page" do
    visit user_path(@user.id)
    expect(page).to have_content(@user.posts[0].title)
    expect(page).to have_content(@user.posts[1].title)
    expect(page).to have_content(@user.posts[2].title)
  end

  it "redirects to the user's post index page when clicking 'See All Posts'" do
    click_button('See All Posts')
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
