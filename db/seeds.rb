if Rails.env.development?
  User.create(name: 'Jane', email: 'jane@example.com', password: 'password', password_confirmation: 'password')
end
