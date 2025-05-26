require "application_system_test_case"

class PageComponentsTest < ApplicationSystemTestCase
  setup do
    @page_component = page_components(:one)
  end

  test "visiting the index" do
    visit page_components_url
    assert_selector "h1", text: "Page components"
  end

  test "should create page component" do
    visit page_components_url
    click_on "New page component"

    click_on "Create Page component"

    assert_text "Page component was successfully created"
    click_on "Back"
  end

  test "should update Page component" do
    visit page_component_url(@page_component)
    click_on "Edit this page component", match: :first

    click_on "Update Page component"

    assert_text "Page component was successfully updated"
    click_on "Back"
  end

  test "should destroy Page component" do
    visit page_component_url(@page_component)
    click_on "Destroy this page component", match: :first

    assert_text "Page component was successfully destroyed"
  end
end
