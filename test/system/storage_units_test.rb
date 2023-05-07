require "application_system_test_case"

class StorageUnitsTest < ApplicationSystemTestCase
  setup do
    @storage_unit = storage_units(:one)
  end

  test "visiting the index" do
    visit storage_units_url
    assert_selector "h1", text: "Storage Units"
  end

  test "creating a Storage unit" do
    visit storage_units_url
    click_on "New Storage Unit"

    fill_in "Address", with: @storage_unit.address
    fill_in "City", with: @storage_unit.city
    fill_in "Name", with: @storage_unit.name
    fill_in "Phone", with: @storage_unit.phone
    fill_in "State", with: @storage_unit.state
    fill_in "Unit", with: @storage_unit.unit
    fill_in "Website", with: @storage_unit.website
    fill_in "Zip", with: @storage_unit.zip
    click_on "Create Storage unit"

    assert_text "Storage unit was successfully created"
    assert_selector "h1", text: "Storage Units"
  end

  test "updating a Storage unit" do
    visit storage_unit_url(@storage_unit)
    click_on "Edit", match: :first

    fill_in "Address", with: @storage_unit.address
    fill_in "City", with: @storage_unit.city
    fill_in "Name", with: @storage_unit.name
    fill_in "Phone", with: @storage_unit.phone
    fill_in "State", with: @storage_unit.state
    fill_in "Unit", with: @storage_unit.unit
    fill_in "Website", with: @storage_unit.website
    fill_in "Zip", with: @storage_unit.zip
    click_on "Update Storage unit"

    assert_text "Storage unit was successfully updated"
    assert_selector "h1", text: "Storage Units"
  end

  test "destroying a Storage unit" do
    visit edit_storage_unit_url(@storage_unit)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Storage unit was successfully destroyed"
  end
end
