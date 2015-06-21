# LIFX Widget for Mac OS X

Control your LIFX lights from your Mac. Uses the LIFX HTTP API to implement a Today Extension. Very much a work-in-progress.

![](Mockup.jpg)

## Development

Install application dependencies using [Carthage](https://github.com/Carthage/Carthage)

    $ carthage bootstrap --platform Mac

Open LIFXWidgetMac.xcodeproj and build the "Widget > My Mac" target.
Choose "Widget Simulator" when prompted to run the application.
