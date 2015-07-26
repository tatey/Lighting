# LIFX Widget for Mac OS X

Control your LIFX lights from your Mac. Uses the LIFX HTTP API to implement a Today Extension. Very much a work-in-progress.

![](Preview.gif)

## Development

Install application dependencies using [Carthage](https://github.com/Carthage/Carthage)

    $ carthage bootstrap --platform Mac

Build the Mac target for setting the access token:

1. Open LIFXWidgetMac.xcodeproj
2. Select "LIFXWidgetMac > My Mac"
3. Run

Build the Widget target for controlling lights:

1. Open LIFXWidgetMac.xcodeproj
2. Select "Widget > My Mac"
3. Run
4. Choose "Widget Simulator" when prompted to run the application

## Copyright

Copyright (C) 2015 Tate Johnson

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see [LICENSE.txt](LICENSE.txt).
