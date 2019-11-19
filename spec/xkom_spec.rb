require 'spec_helper'

desired_caps = {
  caps: {
    platformName:  'Android',
    platformVersion: ENV['SAUCE_LABS'] ? (ENV["ANDROID_PLATFORM_VERSION"] || '7.1') : ENV["ANDROID_PLATFORM_VERSION"],
    deviceName:    ENV["ANDROID_DEVICE_VERSION"] || 'Android',
    app:           ANDROID_APP,
    automationName: 'UIAutomator2',
    # appActivity: '.app.SearchInvoke',
    # autoGrantPermissions: true

  },
  appium_lib: {
    sauce_username:   ENV['SAUCE_LABS'] ? ENV['SAUCE_USERNAME'] : nil,
    sauce_access_key: ENV['SAUCE_LABS'] ? ENV['SAUCE_ACCESS_KEY'] : nil,
    wait: 60
  }
}

describe 'Basic Android selectors' do

  before(:all) do
    @driver = Appium::Driver.new(desired_caps, true).start_driver
  end

  after(:all) do
    @driver.quit
  end

  it 'should send keys to search box and then check the value' do
    search_box_element = @driver.find_element :id, 'searchInput'
    search_box_element.click

    search_box_element = @driver.find_element :id, 'searchInput'
    search_box_element.send_keys 'Monitor'
    @driver.execute_script("mobile:performEditorAction", {"action" => "search"})

    price_elements = @driver.find_elements :id, 'product'
    expect(price_elements.length).to be >= 1
    price_elements.first.click

    add_to_cart = @driver.find_element :id, 'basketFab'
    add_to_cart.click

    accept_button = @driver.find_element :id, 'md_button_positive'
    accept_button.click

    basket_count = @driver.find_element :id, 'basketActionCountBadge'
    expect(basket_count.text).to eql "1"
  end
end
