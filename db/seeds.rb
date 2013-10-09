# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## This will add the verbs to verbs table
verb = Verb.first
Verb.create([{ name: "GET"},{ name: "POST"},{ name: "DELETE"},{ name: "PUT"}]) if verb.blank?

