require "capybara/rspec"
require "./app"
require "pry"
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'the project creation path', {:type => :feature} do
  it 'takes the user to the homepage where they can create a project' do
    visit '/'
    click_link('Add a new project')
    fill_in('project_title', :with => 'Teaching Kids to Code')
    click_button('Go!')
    expect(page).to have_content('Teaching Kids to Code')
  end
end


describe 'the project update path', {:type => :feature} do
  it 'allows a user to change the name of the project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    visit '/'
    click_link('Teaching Kids to Code')
    click_link('Edit project')
    fill_in('name', :with => 'Teaching Ruby to Kids')
    click_button('Update')
    expect(page).to have_content('Teaching Ruby to Kids')
  end
end


describe 'the project delete path', {:type => :feature} do
  it 'allows a user to delete a project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    id = test_project.id
    visit "/projects/#{id}/edit"
    click_button('Delete project')
    visit '/'
    expect(page).not_to have_content("Teaching Kids to Code")
  end
end

describe 'the volunteer detail page path', {:type => :feature} do
  it 'shows a volunteer detail page' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id.to_i
    test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :id => nil})
    test_volunteer.save
    visit "/projects/#{project_id}"
    expect(page).to have_content('Jasmine')
  end
end

describe 'the volunteer creation path', {:type => :feature} do
  it 'creates a volunteer' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id.to_i
    visit "/projects/#{project_id}"
    fill_in('volunteer_name', :with => 'Skinny Pete')
    click_button('add volunteer.')
    expect(page).to have_content('Skinny Pete')
  end
end

describe 'the volunteer delete path', {:type => :feature} do
  it 'allows a user to delete a volunteer' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    volunteer = Volunteer.new({:name => 'Skinny Pete', :project_id=>test_project.id.to_i(), :id=> nil})
    volunteer.save
    visit '/'
    click_link('shortcut to volunteers')
    click_link('Skinny Pete')
    click_button('Delete volunteer')
    expect(page).not_to have_content("Skinny Pete")
  end
end