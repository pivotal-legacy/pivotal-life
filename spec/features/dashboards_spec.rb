require 'spec_helper'

feature "Dashboard" do
  scenario "User sees link to GitHub page" do
    visit "/"
    expect(page).to have_content 'github.com/pivotal/pivotal-life'
  end
end

