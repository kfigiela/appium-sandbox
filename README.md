# appium-sandbox

## Setup

1. Install node
2. `npm install -g appium`
3. Install ruby (and `bundler` gem – not sure if installed by default)
4. `bundle install --path vendor/bundle`
5. Enable USB debugging (security) to allow appium

## Getting element ids

Run `uiautomatorviewer` from android `platform-tools` (next to adb)

## Execute

0. Add `xkom.apk` to main folder of this repo
1. In other console `appium`
2. Connect device
3. `bundle exec rspec`
