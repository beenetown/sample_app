namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_messages
  end
end

def make_users
  admin = User.create!(name: "Example User",
               email: "example@railstutorial.org",
               password: "foobar",
               password_confirmation: "foobar",
               admin: true)
  50.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts    
  users = User.all(limit: 6)
  35.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_messages
  users = User.all(limit: 6)
   users.each do |user|
    10.times do |n|
      content = Faker::Lorem.sentence(4)
      from = user.id
      to = n + 2
      content_with =  "d#{n+2}-#{User.find(n+2).name.split.join('-')} #{content}"
      Message.create(from_id: from,
                 to_id: to,
                 content: content_with)
    end
  end
end




