if Rails.env.development?
  jane = User.create(name: 'Jane', email: 'jane@example.com', password: 'password', password_confirmation: 'password')
  Team.create(name: 'Blue', user_id: jane.id)
  Team.create(name: 'Red', user_id: jane.id)
end
