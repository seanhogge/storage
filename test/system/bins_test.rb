require "application_system_test_case"

class BinsTest < ApplicationSystemTestCase
  setup do
    @bin = bins(:one)
  end

  test "visiting the index" do
    visit bins_url
    assert_selector "h1", text: "Bins"
  end

  test "creating a Bin" do
    visit bins_url
    click_on "New Bin"

    fill_in "Storage unit", with: @bin.storage_unit_id
    click_on "Create Bin"

    assert_text "Bin was successfully created"
    assert_selector "h1", text: "Bins"
  end

  test "updating a Bin" do
    visit bin_url(@bin)
    click_on "Edit", match: :first

    fill_in "Storage unit", with: @bin.storage_unit_id
    click_on "Update Bin"

    assert_text "Bin was successfully updated"
    assert_selector "h1", text: "Bins"
  end

  test "destroying a Bin" do
    visit edit_bin_url(@bin)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Bin was successfully destroyed"
  end
end
