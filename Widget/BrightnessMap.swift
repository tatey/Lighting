//
//  Created by Tate Johnson on 30/08/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Foundation
import LIFXHTTPKit

struct ColorMap {
	enum Key {
        case ultraWarm
        case incandescent
        case warm
        case neutralWarm
        case neutral
        case cool
        case coolDaylight
        case softDaylight
        case daylight
        case noonDaylight
        case brightDaylight
        case cloudyDaylight
        case blueDaylight
        case blueOvercast
        case blueWater
        case blueIce
		case red
		case orange
		case yellow
		case green
		case cyan
		case blue
		case purple
		case pink
	}

	class Value {
		let description: String
		let value: Color

		init(description: String, value: Color) {
			self.description = description
			self.value = value
		}
	}

	fileprivate static let Dictionary: [Key: Value] = [
        .ultraWarm:     Value(description: "Ultra Warm 2500K", value: Color.white(2500)),
        .incandescent:  Value(description: "Incandescent 2750K", value: Color.white(2750)),
        .warm:          Value(description: "Warm 3000K", value: Color.white(3000)),
        .neutralWarm:   Value(description: "Neutral Warm 3200K", value: Color.white(3200)),
        .neutral:       Value(description: "Neutral 3500K", value: Color.white(3500)),
        .cool:          Value(description: "Cool 4000K", value: Color.white(4000)),
        .coolDaylight:  Value(description: "Cool Daylight 4500K", value: Color.white(4500)),
        .softDaylight:  Value(description: "Soft Daylight 5000K", value: Color.white(5000)),
        .daylight:      Value(description: "Daylight 5500K", value: Color.white(5500)),
        .noonDaylight:  Value(description: "Noon Daylight 6000K", value: Color.white(6000)),
        .brightDaylight: Value(description: "Bright Daylight 6500K", value: Color.white(6500)),
        .cloudyDaylight: Value(description: "Cloudy Daylight 7000K", value: Color.white(7000)),
        .blueDaylight:  Value(description: "Blue Daylight 7500K", value: Color.white(7500)),
        .blueOvercast:  Value(description: "Blue Overcast 8000K", value: Color.white(8000)),
        .blueWater:     Value(description: "Blue Water 8500K", value: Color.white(8500)),
        .blueIce:       Value(description: "Blue Ice 9000K", value: Color.white(9000)),
		.red:           Value(description: "Red",        value: Color.color(0,   saturation: 1)),
		.orange:        Value(description: "Orange",    value: Color.color(40,  saturation: 1)),
		.yellow:        Value(description: "Yellow",     value: Color.color(60,  saturation: 1)),
		.green:         Value(description: "Green",      value: Color.color(120, saturation: 1)),
		.cyan:          Value(description: "Cyan",       value: Color.color(180, saturation: 1)),
		.blue:          Value(description: "Blue",       value: Color.color(240, saturation: 1)),
		.purple:        Value(description: "Purple",     value: Color.color(280, saturation: 1)),
		.pink:          Value(description: "Pink",       value: Color.color(320, saturation: 1)),
	]

	static func valueForKey(_ key: Key) -> Value {
		return Dictionary[key]!
	}
}
