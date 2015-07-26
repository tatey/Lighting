# Lighting - Control LIFX lights from your Mac

A Mac OS X widget for toggling LIFX lights via the [LIFX HTTP API](http://api.developer.lifx.com/docs).
Built on top of [LIFXHTTPKit](https://github.com/tatey/LIFXHTTPKit).

![Video recording of using the widget](Screenshot-Preview.gif)

*Note: This is not an official LIFX project.*

## Build Dependencies

* Xcode 6.4
* Swift 1.3
* Mac OS X 10.10
* Carthage

## Development

Install application dependencies using [Carthage](https://github.com/Carthage/Carthage).

    $ carthage bootstrap --platform Mac

Then build one of the targets.

### Main target

![Configure access token](Screenshot-Main-Target.jpg)

1. Open Lighting.xcodeproj
2. Select "Main > My Mac"
3. Run

### Widget Target

![Control lighting](Screenshot-Widget-Target.jpg)

1. Open Lighting.xcodeproj
2. Select "Widget > My Mac"
3. Run
4. Pick "Widget Simulator" when prompted to run the application

## Copyright

Following files, directories and their contents are copyright [Webalys Limited](http://streamlineicons.com).
You may not reuse anything therein without purchasing a license:

* Main/Images.xcassets/logged-in-icon-success.imageset/Icons-48px.png
* Main/Images.xcassets/logged-in-icon-success.imageset/Icons-48px@2x.png

All other files and directories are copyright Tate Johnson and licensed under
the GPLv3 license. See [LICENSE](LICENSE.txt).
