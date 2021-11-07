users = [
  { fname: 'Jon', lname: 'Doe' },
  { fname: 'Jane', lname: 'Doe' }
]

users.each do |u|
  User.create(u)
end
