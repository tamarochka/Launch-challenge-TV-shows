require 'rails_helper'

feature 'user adds favorite TV show characters', %Q{
  As a site visitor
I want to add my favorite TV show characters
So that other people can enjoy their crazy antics


} do

  # Acceptance Criteria:
  # * I can access a form to add a character on a TV show's page
  # * I must specify the character's name and the actor's name
  # * I can optionally provide a description
  # * If I do not provide the required information, I receive an error message
  # * If the character already exists in the database, I receive an error message

  scenario 'user adds new characters' do
    attrs = {
      name: 'Name_character',
      actors_name: 'actor',
      description: 'blah-blah-blah'

    }

    chracter = Character.new(attrs)

    visit '/television_shows/new'
    fill_in 'Name', with: character.name
    fill_in 'Actors Name', with: character.actors_name
    fill_in 'Description', with: character.description
    click_on 'Submit'

    expect(page).to have_content 'Character Successfully added'
    expect(page).to have_content character.actors_name
    expect(page).to_not have_content character.description
  end

  scenario 'without required attributes' do
    visit '/television_shows/new'
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "can't be blank"
  end

  scenario 'user cannot add character that already exists' do
    attrs = {
      name: 'Name_character',
      actors_name: 'actor'
    }

    character = Character.create(attrs)

    visit '/television_shows/new'
    fill_in 'Name', with: character.name
    fill_in 'Actor', with: character.actor
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "has already been taken"
  end
end
