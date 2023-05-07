require "application_system_test_case"

class ContentsTest < ApplicationSystemTestCase
  setup do
    @content = contents(:one)
  end

  test "visiting the index" do
    visit contents_url
    assert_selector "h1", text: "Contents"
  end

  test "creating a Content" do
    visit contents_url
    click_on "New Content"

    fill_in "Bin", with: @content.bin_id
    fill_in "Condition", with: @content.condition
    fill_in "Name", with: @content.name
    click_on "Create Content"

    assert_text "Content was successfully created"
    assert_selector "h1", text: "Contents"
  end

  test "updating a Content" do
    visit content_url(@content)
    click_on "Edit", match: :first

    fill_in "Bin", with: @content.bin_id
    fill_in "Condition", with: @content.condition
    fill_in "Name", with: @content.name
    click_on "Update Content"

    assert_text "Content was successfully updated"
    assert_selector "h1", text: "Contents"
  end

  test "destroying a Content" do
    visit edit_content_url(@content)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Content was successfully destroyed"
  end
end
