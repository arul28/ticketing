# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Admin.create!(
  username: "admin_username",
  name: "Admin Name",
  email: "admin@example.com",
  password: "secure_password",
  phone_number: "1234567890",
  address: "Admin Address",
  credit_number: "1234567890123456"
)
