feature "Welcome to Chitter!" do

  scenario "I see a welcome page with a greeting" do
    visit('/')
    expect(page).to have_content "Welcome to Chitter!"
  end

end
