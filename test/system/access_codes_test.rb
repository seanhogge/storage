require "application_system_test_case"

class AccessCodesTest < ApplicationSystemTestCase
  setup do
    @access_code = access_codes(:one)
  end

  test "visiting the index" do
    visit access_codes_url
    assert_selector "h1", text: "Access Codes"
  end

  test "creating a Access code" do
    visit access_codes_url
    click_on "New Access Code"

    fill_in "Code", with: @access_code.code
    fill_in "Name", with: @access_code.name
    fill_in "Storage unit", with: @access_code.storage_unit_id
    click_on "Create Access code"

    assert_text "Access code was successfully created"
    assert_selector "h1", text: "Access Codes"
  end

  test "updating a Access code" do
    visit access_code_url(@access_code)
    click_on "Edit", match: :first

    fill_in "Code", with: @access_code.code
    fill_in "Name", with: @access_code.name
    fill_in "Storage unit", with: @access_code.storage_unit_id
    click_on "Update Access code"

    assert_text "Access code was successfully updated"
    assert_selector "h1", text: "Access Codes"
  end

  test "destroying a Access code" do
    visit edit_access_code_url(@access_code)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Access code was successfully destroyed"
  end
end
