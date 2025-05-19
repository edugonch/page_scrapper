require "test_helper"

class LinkTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      username: "testuser",
      email: "test@example.com",
      password: "password"
    )

    @page = ScrapedPage.create!(
      user: @user,
      url: "http://example.com",
      title: "Example Page",
      status: "pending"
    )
  end

  test "should be valid with href and scraped_page" do
    link = Link.new(href: "http://link.com", name: "Link Name", scraped_page: @page)
    assert link.valid?
  end

  test "should not be valid without href" do
    link = Link.new(name: "No Href", scraped_page: @page)
    assert_not link.valid?
    assert_includes link.errors[:href], "can't be blank"
  end

  test "should not be valid without scraped_page" do
    link = Link.new(href: "http://link.com", name: "Orphan Link")
    assert_not link.valid?
    assert_includes link.errors[:scraped_page], "must exist"
  end

  test "should belong to a scraped_page" do
    link = Link.create!(href: "http://link.com", name: "BelongsTo", scraped_page: @page)
    assert_equal @page, link.scraped_page
  end
end
