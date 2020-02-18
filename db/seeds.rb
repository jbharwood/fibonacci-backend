# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Fibonacci.find_each(&:destroy)
FibPrime.find_each(&:destroy)
Fibonacci.create(input: 0, list: [0])
Fibonacci.create(input: 1, list: [1])
FibPrime.create(list: [	1, 1, 2, 3, 5, 13, 89, 233, 1597, 28657, 514229, 433494437, 2971215073, 99194853094755497, 1066340417491710595814572169, 19134702400093278081449423917, 475420437734698220747368027166749382927701417016557193662268716376935476241])
