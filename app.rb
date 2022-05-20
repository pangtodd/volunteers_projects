require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects = Project.all
  erb(:projects)
end

get('/projects')
  @projects = Project.all
  erb(:projects)

  post('/projects') do
    name = params[:project_title]
    project = Project.new(name, nil)
    project.save()
    erb(:projects)
  end

get('/projects/new') do
  erb(:new_project)
end