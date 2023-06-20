require 'rails_helper'
require 'capybara/rspec'
RSpec.describe 'User Index Page', type: :feature do
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

    
  end

  it "displays the number of posts each user has written" do
    visit users_path
    expect(page).to have_content("Number of posts 12")
    expect(page).to have_content("Number of posts 130")  
 
  end
  
  it "redirects to the user's show page when clicking on a user" do
    visit users_path
    click_link(@user2.name, href: user_path(@user2))
    expect(page).to have_current_path(user_path(@user2.id))
  end
  
end
