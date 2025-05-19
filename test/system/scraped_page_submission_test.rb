require "application_system_test_case"

class ScrapedPageSubmissionTest < ApplicationSystemTestCase
  driven_by :rack_test

  setup do
    @user = User.create!(
      username: "testuser",
      email: "test@example.com",
      password: "password"
    )
  end

  test "user submits a page URL and sees the new page in the list" do
    visit new_user_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  
    visit new_scraped_page_path
    fill_in "Url", with: "https://www.w3schools.com"
    click_button "Scrape this page"
  
    assert_text "Scraped Pages"
    assert_text "www.w3schools.com"
    assert_text "Processing"
  end
end
