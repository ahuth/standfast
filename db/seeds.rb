def create_data!
  create_jane!
  print_info
end

def create_jane!
  jane = User.create(name: 'Jane', email: 'jane@example.com', password: 'password', password_confirmation: 'password')
  blue_team = Team.create(name: 'Blue', user_id: jane.id)
  red_team = Team.create(name: 'Red', user_id: jane.id)
  Seat.create(name: 'Adam', email: 'adam@example.com', team_id: blue_team.id)
  Seat.create(name: 'Eric', email: 'eric@example.com', team_id: blue_team.id)
  Seat.create(name: 'Ryan', email: 'ryan@example.com', team_id: blue_team.id)
  Seat.create(name: 'Shirish', email: 'shirish@example.com', team_id: blue_team.id)
  Seat.create(name: 'Goose', email: 'goose@example.com', team_id: red_team.id)
  Seat.create(name: 'Iceman', email: 'iceman@example.com', team_id: red_team.id)
  Seat.create(name: 'Maverick', email: 'maverick@example.com', team_id: red_team.id)
end

def print_info
  puts <<~EOS
    ==================================
    Created the following users:
    - jane@example.com

    Each has a password of 'password'.
    ==================================
  EOS
end

create_data! if Rails.env.development?
