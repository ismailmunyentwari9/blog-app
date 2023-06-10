require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:example) do
    @user = User.new(name: 'John',
                     photo: 'https://static.wikia.nocookie.net/tomandjerry/images/1/14/Tom_Cat_2.png/revision/latest?cb=20200412163656',
                     bio: 'I am a cat')
  end

  subject { Post.new(author: @user, title: 'Hello', text: 'This is my first post') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without an author' do
      subject.author = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if title is blank' do
      subject.title = ''
      expect(subject).to_not be_valid
    end

    it 'is not valid if title is longer than 250 words' do
      subject.title = 'A' * 251
      expect(subject).to_not be_valid
    end

    it 'is not valid without a valid comments counter' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'has a default comments_counter of 0' do
      expect(subject.comments_counter).to eq(0)
    end

    it 'is not valid without a valid likes counter' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'has a default likes_counter of 0' do
      expect(subject.likes_counter).to eq(0)
    end
  end

  describe 'Recent Comments' do
    it 'should have a maximum of 5 comments' do
      Comment.create(post: subject, author: @user, text: 'Hi Tom!')
      Comment.create(post: subject, author: @user, text: 'Long Time no see!')
      Comment.create(post: subject, author: @user, text: 'WHUB!')
      Comment.create(post: subject, author: @user, text: 'Hey')
      Comment.create(post: subject, author: @user, text: 'Yeah, Been a while')
      Comment.create(post: subject, author: @user, text: 'I am just staying silent on social media')

      expect(subject.recent_comments.length).to eq(5)
    end

    it 'should only include the 5 most recent comments' do
      first_comment = Comment.create(post: subject, author: @user, text: 'Hi Tom!')
      Comment.create(post: subject, author: @user, text: 'Long Time no see!')
      Comment.create(post: subject, author: @user, text: 'WHUB!')
      Comment.create(post: subject, author: @user, text: 'Hey')
      Comment.create(post: subject, author: @user, text: 'Yeah, Been a while')
      Comment.create(post: subject, author: @user, text: 'I am just staying silent on social media')

      expect(subject.recent_comments).to_not include(first_comment)
    end
  end
end
