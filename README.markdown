![](Design/README/Logo.png)

# Lighting: Control LIFX lights from your Mac [![GitHub release](https://img.shields.io/github/release/tatey/Lighting.svg)](https://github.com/tatey/Lighting/releases/latest) [![GitHub license](https://img.shields.io/github/license/tatey/Lighting.svg)](https://raw.githubusercontent.com/tatey/Lighting/master/LICENSE.txt)

A macOS widget for controlling LIFX lights via the [LIFX HTTP API](http://api.developer.lifx.com/docs). Built on top of [LIFXHTTPKit](https://github.com/tatey/LIFXHTTPKit).

![](Design/README/ScreenshotPreview3.gif)
![](Design/README/ScreenshotPreview4.gif)

*Note: This is not an official LIFX project.*

## Installation

Requires macOS 10.12 Sierra, 10.11 El Capitan, or 10.10 Yosemite.

1. Download the [latest zip file](https://github.com/tatey/Lighting/releases/latest),
   extract the binary, and drag into your Application folder.
2. Open "Lighting.app" and login with your personal access token.
3. Open Notification Center and add the "Lighting" widget.

Alternatively, you can install via Homebrew-Cask.

    $ brew cask install lighting

## Development

First, you need the following system dependencies:

* Swift 3.0 (Xcode 8.3)
* macOS 10.10+
* [Carthage](https://github.com/Carthage/Carthage)

Then, install the application dependencies:

    $ carthage bootstrap --platform Mac

Finally, build the "Main" or "Widget" target.

### Main target

The main target is responsible for configuring the access token. It notifies
the widget when the access token changes.

![](Design/README/ScreenshotTargetMain.jpg)

1. Open Lighting.xcodeproj
2. Select "Main > My Mac"
3. Run

### Widget Target

The widget target implements a view controller conforming to `NCWidgetProviding`
for toggling lights on and off.

![](Design/README/ScreenshotTargetWidget.png)

1. Open Lighting.xcodeproj
2. Select "Widget > My Mac"
3. Run
4. Pick "Widget Simulator" when prompted to run the application

## Special Thanks

Thanks to the following people for helping to improve this project:

* [@segan5](https://github.com/segan5)
* [@TheDaem0n](https://github.com/TheDaem0n)
* [@lucymhdavies](https://github.com/lucymhdavies)
* [@lparry](https://github.com/lparry)
* [@jamesottaway](https://github.com/jamesottaway)

## Copyright

Following files, directories and their contents are copyright [Webalys Limited](http://streamlineicons.com).
You may not reuse anything therein without purchasing a license:

* Main/Images.xcassets/logged-in-icon-success.imageset/Icons-48px.png
* Main/Images.xcassets/logged-in-icon-success.imageset/Icons-48px@2x.png

All other files and directories are copyright Tate Johnson and licensed under
the GPLv3 license. See [LICENSE](LICENSE.txt).
