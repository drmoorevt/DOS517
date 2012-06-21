# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added this to seed the admin user
User.delete_all
User.create(:admin_flag => 1,
  :description =>  "The immortal administrator",
  :username =>  "admin",
  :email =>  "admin@super-twitty.com",
  :password =>  "admin",
  :first_name =>  "Administrator",
  :last_name =>  "ST")

Post.delete_all
Comment.delete_all
