require 'rails_helper'

feature 'views favorite TV characters', %Q{
  As a site visitor
I want to view a list of people's favorite TV characters
So I can find wonky characters to watch


} do

  # Acceptance Criteria:
  # * I can see a list of all the characters
  # * The character's name and the TV show it is associated with are listed

  scenario "user views favorite TV characters page" do
    show = TelevisionShow.create(title: 'Movies', network: 'Disney')
    characters = []
    character_attrs=[{name: "First", actor: "actor1", television_show_id: show.id},
      {name: "Second", actor: "actor2", television_show_id: show.id}]

    character_attrs.each do |attrs|
    characters << Character.create(attrs)
  end


  visit "/television_shows/#{show.id}"
  characters.each do |character|
    expect(page).to have_content character.name
    expect(page).to have_content show.title
  end
end
end
