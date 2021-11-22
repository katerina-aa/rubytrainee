users = [
  { fname: 'Jon', lname: 'Doe', phone: '0957518355', city: 'Kharkiv', age: 25 },
  { fname: 'Jane', lname: 'Doe', phone: '0988818355', city: 'Kyiv', age: 40 }
]

users.each do |u|
  User.create(u)
end

=begin
auth_data = [
  { username: 'admin', password: 'admin' },
  { username: 'katya', password: 'katya' }
]

auth_data.each do |u|
  Auth.create(u)
end
=end
