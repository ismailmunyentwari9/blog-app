require 'rails_helper'
require 'capybara/rspec'
RSpec.describe 'User Index Page', type: :feature, js: true do
  before do
    # Create sample users and posts
    @user1 = User.create!(name: "User 1", photo: "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png", posts_counter: 12)
    @user2 = User.create!(name: "User 2", photo: "https://cdn-icons-png.flaticon.com/512/21/21104.png", posts_counter: 130)
    @user1.posts.create!(title: "Post 1", text: "Text for Post 1")
    @user2.posts.create!(title: "Post 2", text: "Text for Post 2")
  end

  it "displays the username of all other users" do
    visit users_path
    expect(page).to have_content("User 1")
    expect(page).to have_content("User 2")
  end

  it "displays the profile picture for each user" do
    visit users_path
    expect(page).to have_css("img")
    expect(page).to have_css("img")
    
  end

  it "displays the number of posts each user has written" do
    visit users_path
    post_counter=user1.posts_counter
    expect(post_counter).to eq(12)

  end

  it "redirects to the user's show page when clicking on a user" do
    visit users_path
    click_link "User 1"
    expect(current_path).to eq(user_path(User.first))
  end
end
