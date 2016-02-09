# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tasks = Task.create([
    {
    name: 'Terminar o app', description:'tenho que fazer ate dia 13', goal: DateTime.strptime("13/2/2016", "%d/%m/%Y")
    },
    {
    name: 'Contruir uma cabana', description:'tenho que fazer ate domingo', goal: DateTime.strptime("13/2/2016", "%d/%m/%Y")
    }
])

sbtasks = Subtask.create([
    {
    name: 'primeiro modulo', description:'tenho que fazer ate dia 13', goal: DateTime.strptime("13/2/2016", "%d/%m/%Y"), task_id: 1
    },
    {
    name: 'segundo modolo', description:'tenho que fazer ate domingo', goal: DateTime.strptime("13/2/2016", "%d/%m/%Y"), task_id: 1, complete: true
    }
])