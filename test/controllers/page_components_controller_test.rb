require "test_helper"

class PageComponentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_component = page_components(:one)
  end

  test "should get index" do
    get page_components_url
    assert_response :success
  end

  test "should get new" do
    get new_page_component_url
    assert_response :success
  end

  test "should create page_component" do
    assert_difference("PageComponent.count") do
      post page_components_url, params: { page_component: {} }
    end

    assert_redirected_to page_component_url(PageComponent.last)
  end

  test "should show page_component" do
    get page_component_url(@page_component)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_component_url(@page_component)
    assert_response :success
  end

  test "should update page_component" do
    patch page_component_url(@page_component), params: { page_component: {} }
    assert_redirected_to page_component_url(@page_component)
  end

  test "should destroy page_component" do
    assert_difference("PageComponent.count", -1) do
      delete page_component_url(@page_component)
    end

    assert_redirected_to page_components_url
  end
end
