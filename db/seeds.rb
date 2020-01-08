# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Roles
Role.create(name: "Administrator", code_name: 'administrator')
Role.create(name: "Challenger", code_name: 'challenger')

#Users
User.create(name: 'Alejandro Guevara', email: 'alejandro.guevara@thincode.com', password: 'age', password_confirmation: 'age', role_id: 1)
User.create(name: 'Alfredo Renteria ', email: 'alfredo.renteria@thincode.com', password: 'arv', password_confirmation: 'arv', role_id: 2)
User.create(name: 'Carlos Rivera', email: 'carlos.rivera@thincode.com', password: 'cnr', password_confirmation: 'cnr', role_id: 2)
User.create(name: 'Eddy Caudillo', email: 'alejandro.caudillo@thincode.com', password: 'eacd', password_confirmation: 'eadc', role_id: 2)
User.create(name: 'Gerardo Rocha', email: 'gerardo.rocha@thincode.com', password: 'gdrm', password_confirmation: 'gdrm', role_id: 1)
User.create(name: 'Jorge Jasso', email: 'jorge.jasso@thincode.com', password: 'jajt', password_confirmation: 'jajt', role_id: 2)
User.create(name: 'Julio Acevedo', email: 'julio.acevedo@thincode.com', password: 'jeam', password_confirmation: 'jeam', role_id: 2)
User.create(name: 'Maricela Valdez', email: 'maricela.valdez@thincode.com', password: 'mvg', password_confirmation: 'mvg', role_id: 2)
User.create(name: 'Majo Guzman', email: 'maria.guzman@thincode.com', password: 'mjgv', password_confirmation: 'gdrm', role_id: 2)
User.create(name: 'Raul Almanza', email: 'raul.almanza@thincode.com', password: 'rav', password_confirmation: 'rav', role_id: 2)