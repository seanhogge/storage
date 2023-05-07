require "test_helper"

class StorageUnitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @storage_unit = storage_units(:one)
  end

  test "should get index" do
    get storage_units_url
    assert_response :success
  end

  test "should get new" do
    get new_storage_unit_url
    assert_response :success
  end

  test "should create storage_unit" do
    assert_difference("StorageUnit.count") do
      post storage_units_url, params: { storage_unit: { address: @storage_unit.address, city: @storage_unit.city, name: @storage_unit.name, phone: @storage_unit.phone, state: @storage_unit.state, unit: @storage_unit.unit, website: @storage_unit.website, zip: @storage_unit.zip } }
    end

    assert_redirected_to storage_unit_url(StorageUnit.last)
  end

  test "should show storage_unit" do
    get storage_unit_url(@storage_unit)
    assert_response :success
  end

  test "should get edit" do
    get edit_storage_unit_url(@storage_unit)
    assert_response :success
  end

  test "should update storage_unit" do
    patch storage_unit_url(@storage_unit), params: { storage_unit: { address: @storage_unit.address, city: @storage_unit.city, name: @storage_unit.name, phone: @storage_unit.phone, state: @storage_unit.state, unit: @storage_unit.unit, website: @storage_unit.website, zip: @storage_unit.zip } }
    assert_redirected_to storage_unit_url(@storage_unit)
  end

  test "should destroy storage_unit" do
    assert_difference("StorageUnit.count", -1) do
      delete storage_unit_url(@storage_unit)
    end

    assert_redirected_to storage_units_url
  end
end
