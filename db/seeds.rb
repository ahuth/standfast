if Rails.env.development?
  # Account
  account = Account.first || Account.create!

  # User
  jane = User.find_or_initialize_by({
    account_id: account.id,
    email: 'jane@example.com'
  })
  jane.password = 'password'
  jane.encrypted_password = User.new.send(:password_digest, 'password')
  jane.save!

  # Teams
  blue_team = Team.find_or_create_by!(name: 'Blue', account_id: account.id, time_zone: "Pacific Time (US & Canada)")
  red_team = Team.find_or_create_by!(name: 'Red', account_id: account.id, time_zone: "Pacific Time (US & Canada)")

  # Seats
  Seat.find_or_create_by!(name: 'Adam', email: 'adam@example.com', team_id: blue_team.id)
  Seat.find_or_create_by!(name: 'Eric', email: 'eric@example.com', team_id: blue_team.id)
  ryan_seat = Seat.find_or_create_by!(name: 'Ryan', email: 'ryan@example.com', team_id: blue_team.id)
  shirish_seat = Seat.find_or_create_by!(name: 'Shirish', email: 'shirish@example.com', team_id: blue_team.id)
  anna_seat = Seat.find_or_create_by!(name: 'Anna', email: 'anna@example.com', team_id: blue_team.id)
  Seat.find_or_create_by!(name: 'Goose', email: 'goose@example.com', team_id: red_team.id)
  Seat.find_or_create_by!(name: 'Iceman', email: 'iceman@example.com', team_id: red_team.id)
  Seat.find_or_create_by!(name: 'Maverick', email: 'maverick@example.com', team_id: red_team.id)

  # Responses
  Response.find_or_create_by!(handled: false, seat_id: shirish_seat.id, body: <<~EOS)
    Beat Eric at Ping-Pong!
  EOS
  Response.find_or_create_by!(handled: false, seat_id: ryan_seat.id, body: <<~EOS)
    - Started expense sync
    - Deployed to staging
  EOS
  Response.find_or_create_by!(handled: false, seat_id: anna_seat.id, body: <<~EOS)
    Finished the machine learning algorithm.
  EOS

  puts <<~EOS
    ==================================
    Created the following users:
    - jane@example.com

    Each has a password of 'password'.
    ==================================
  EOS
end
