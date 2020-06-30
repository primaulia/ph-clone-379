require "application_system_test_case"

# in RSpec
# describe "<features description>" do
#   it "<expectation description>" do
#   end
# end

class ProductsTest < ApplicationSystemTestCase
  test "lets anyone see all products" do
    visit "/" #open browse go to "/"
    assert_selector "h1", text: "Awesome Products" #check if there's select "h1", and the content is "Awesome Products"
    assert_selector ".product", count: Product.count
  end

  test "lets a signed in user create a new product" do
    login_as users(:george)
    visit root_path

    click_on "Create Product"
    save_and_open_screenshot

    fill_in "product_name", with: "Le Wagon"
    fill_in "product_tagline", with: "Change your life: Learn to code"
    # save_and_open_screenshot

    click_on 'Create Product'
    # save_and_open_screenshot

    # Should be redirected to Home with new product
    assert_equal root_path, page.current_path
    assert_text "Change your life: Learn to code"
  end

  test "lets a signed in user to view one product" do 
    login_as users(:george)
    visit root_path

    # pull out the instance of product with fixtures
    skello = products(:skello)
    click_on skello.name

    # check if user is redirected once clicking the link
    assert_equal product_path(skello), page.current_path
    assert_selector "h1", text: "Skello"
    # save_and_open_screenshot
  end
end
