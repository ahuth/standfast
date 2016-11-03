if Rails.env.development?
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
