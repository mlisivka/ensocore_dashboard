# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Order.delete_all

Order.create([
  { first_name: 'Daenerys', last_name: 'Targaryen',
    email: 'd.targaryen@gmail.com', amount: rand(1..1000)},
  { first_name: 'Jorah', last_name: 'Mormont',
    email: 'j.mormont@gmail.com', amount: rand(1..1000)},
  { first_name: 'John', last_name: 'Snow',
    email: 'j.snow@gmail.com', amount: rand(1..1000)},
])
