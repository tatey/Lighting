//
//  Created by Tate Johnson on 30/08/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Foundation
import LIFXHTTPKit

struct ColorMap {
	enum Key {
		case hotWhite
		case warmWhite
		case coolWhite
		case coldWhite
		case blueWhite
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
		.hotWhite:  Value(description: "Hot White",  value: Color.white(2500)),
		.warmWhite: Value(description: "Warm White", value: Color.white(3500)),
		.coolWhite: Value(description: "Cool White", value: Color.white(4500)),
		.coldWhite: Value(description: "Cold White", value: Color.white(5500)),
		.blueWhite: Value(description: "Blue White", value: Color.white(9000)),
		.red:       Value(description: "Red",        value: Color.color(0,   saturation: 1)),
		.orange:    Value(description: "Orange",    value: Color.color(40,  saturation: 1)),
		.yellow:    Value(description: "Yellow",     value: Color.color(60,  saturation: 1)),
		.green:     Value(description: "Green",      value: Color.color(120, saturation: 1)),
		.cyan:      Value(description: "Cyan",       value: Color.color(180, saturation: 1)),
		.blue:      Value(description: "Blue",       value: Color.color(240, saturation: 1)),
		.purple:    Value(description: "Purple",     value: Color.color(280, saturation: 1)),
		.pink:      Value(description: "Pink",       value: Color.color(320, saturation: 1)),
	]

	static func valueForKey(_ key: Key) -> Value {
		return Dictionary[key]!
	}
}
