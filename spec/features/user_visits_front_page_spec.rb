require 'rails_helper'


feature 'user visits front page' do

  scenario 'visitor is not logged in' do
    visit root_path
    expect(page).to have_content 'Seeing the Roses'

  end

end
