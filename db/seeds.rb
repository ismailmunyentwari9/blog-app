# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(
  name: 'Alice Johnson',
  email: 'alice@example.com',
  photo: 'https://assets.stickpng.com/images/585e4bcdcb11b227491c3396.png',
  bio: 'Nature enthusiast and outdoor adventurer.',
  posts_counter: 8,
  password: 'password789',
  password_confirmation: 'password789'
)

User.create(
  name: 'Michael Wilson',
  email: 'michael@example.com',
  photo: 'https://icons.veryicon.com/png/o/internet--web/prejudice/user-128.png',
  bio: 'Tech geek with a passion for coding and gadgets.',
  posts_counter: 12,
  password: 'password321',
  password_confirmation: 'password321'
)

User.create(
  name: 'Emily Davis',
  email: 'emily@example.com',
  photo: 'https://icons.veryicon.com/png/o/internet--web/prejudice/user-128.png',
  bio: 'Bookworm, coffee lover, and aspiring writer.',
  posts_counter: 3,
  password: 'password987',
  password_confirmation: 'password987'
)
User.all.each do |user|
  3.times do
    user.posts.create(
      title: 'Sample Post',
      text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      comments_counter: 0,
      likes_counter: 0
    )
  end
  3.times do
    post = user.posts.create(
      title: 'Sample Post',
      text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      comments_counter: 12,
      likes_counter: 56
    )

    post.update(comments_counter: 20, likes_counter: 40)
  end
end
comments = [
  'Great post!',
  'I completely agree.',
  'Well said!',
  'Thanks for sharing.',
  'I learned something new.',
  'This is inspiring.',
  'I appreciate your perspective.',
  'Interesting read.',
  'I enjoyed this.',
  'Brilliant insights!'
]

User.all.each do |user|
  Post.all.each do |post|
    comments.each do |comment_text|
      user.comments.create(
        post_id: post.id,
        text: comment_text
      )
    end
  end
end
