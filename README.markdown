# LIFX Widget for Mac OS X

Control your LIFX lights from your Mac. Uses the LIFX HTTP API to implement a Today Extension. Very much a work-in-progress.

![Video recording of using the widget](Screenshot-Preview.gif)

## Development

Install application dependencies using [Carthage](https://github.com/Carthage/Carthage)

    $ carthage bootstrap --platform Mac

### Main target

![Configure access token](Screenshot-Main-Target.jpg)

1. Open LIFXWidgetMac.xcodeproj
2. Select "Main > My Mac"
3. Run

### Widget Target

![Control lighting](Screenshot-Widget-Target.jpg)

1. Open LIFXWidgetMac.xcodeproj
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
