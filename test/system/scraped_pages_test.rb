require "application_system_test_case"

class ScrapedPagesTest < ApplicationSystemTestCase
  setup do
    @user = User.create!(
      username: "testuser",
      email: "test@example.com",
      password: "password"
    )

    # Create 2 pages for the user
    @page1 = ScrapedPage.create!(
      user: @user,
      url: "http://example1.com",
      title: "Example 1",
      status: "completed"
    )

    @page1.links.create!(href: "http://link1.com", name: "Link 1")
    @page1.links.create!(href: "http://link2.com", name: "Link 2")

    @page2 = ScrapedPage.create!(
      user: @user,
      url: "http://example2.com",
      title: "Example 2",
      status: "completed"  # <-- FIXED here
    )

    @page2.links.create!(href: "http://anotherlink.com", name: "Another")
  end

  test "user sees list of their scraped pages" do
    visit new_user_session_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_button "Log in"

    visit scraped_pages_path

    assert_text "Example 1"
    assert_text "Links Found: 2"

    assert_text "Example 2"
    assert_text "Links Found: 1"

    assert_text "Status: Completed", count: 2  # More precise
  end
end
