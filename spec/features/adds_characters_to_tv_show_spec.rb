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
      actor: 'actor',
      description: 'blah-blah-blah'

    }
    show = TelevisionShow.create(title: 'Movies',network: 'Disney')

    character = Character.new(attrs)

    visit "/television_shows/#{show.id}/characters/new"
    fill_in 'Name', with: character.name
    fill_in 'Actor', with: character.actor
    fill_in 'Description', with: character.description
    click_on 'Submit'

    expect(page).to have_content 'Character Successfully added'
    expect(page).to have_content character.name
    expect(page).to have_content character.actor
    expect(page).to have_content character.description
  end

  scenario 'without required attributes' do
    show = TelevisionShow.create(title: 'Movies',network: 'Disney' )
    visit "/television_shows/#{show.id}/characters/new"
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "can't be blank"
  end

  scenario 'user cannot add character that already exists' do
    show = TelevisionShow.create(title: 'Movies',
      network: 'Disney' )
    attrs = {
      name: 'Name_character',
      actor: 'actor',
      television_show_id: show.id
    }

    character = Character.create(attrs)

    visit "/television_shows/#{show.id}/characters/new"
    fill_in 'Name', with: character.name
    fill_in 'Actor', with: character.actor
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "has already been taken"
  end
end
