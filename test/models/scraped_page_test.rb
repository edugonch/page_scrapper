require "test_helper"

class ScrapedPageTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      username: "testuser",
      email: "tes#{SecureRandom.hex(4)}t@example.com",
      password: "password"
    )
  end

  test "should not save without url" do
    page = ScrapedPage.new(user: @user)
    assert_not page.save, "Saved a scraped page without a URL"
  end

  test "should default status to pending" do
    page = ScrapedPage.create!(url: "http://example.com", user: @user)
    assert_equal "pending", page.status
  end

  test "should not accept invalid status" do
    assert_raises(ActiveRecord::RecordInvalid) do
      ScrapedPage.create!(url: "http://invalid.com", user: @user, status: "not_a_real_status")
    end
  end

  test "should belong to a user" do
    page = ScrapedPage.create!(url: "http://example.com", user: @user)
    assert_equal @user, page.user
  end

  test "should destroy associated links when destroyed" do
    page = ScrapedPage.create!(url: "http://example.com", user: @user)
    page.links.create!(href: "http://link1.com", name: "Link 1")
    page.links.create!(href: "http://link2.com", name: "Link 2")

    assert_difference("Link.count", -2) do
      page.destroy
    end
  end
end
