//
//  Created by Tate Johnson on 30/08/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Foundation
import LIFXHTTPKit

struct ColorMap {
	enum Key {
		case HotWhite
		case WarmWhite
		case CoolWhite
		case ColdWhite
		case BlueWhite
		case Red
		case Orange
		case Yellow
		case Green
		case Cyan
		case Blue
		case Purple
		case Pink
	}

	class Value {
		let description: String
		let value: Color

		init(description: String, value: Color) {
			self.description = description
			self.value = value
		}
	}

	private static let Dictionary: [Key: Value] = [
		.HotWhite:  Value(description: "Hot White",  value: Color.white(2500)),
		.WarmWhite: Value(description: "Warm White", value: Color.white(3500)),
		.CoolWhite: Value(description: "Cool White", value: Color.white(4500)),
		.ColdWhite: Value(description: "Cold White", value: Color.white(5500)),
		.BlueWhite: Value(description: "Blue White", value: Color.white(9000)),
		.Red:       Value(description: "Red",        value: Color.color(0,   saturation: 1)),
		.Orange:    Value(description: "Orange",    value: Color.color(40,  saturation: 1)),
		.Yellow:    Value(description: "Yellow",     value: Color.color(60,  saturation: 1)),
		.Green:     Value(description: "Green",      value: Color.color(120, saturation: 1)),
		.Cyan:      Value(description: "Cyan",       value: Color.color(180, saturation: 1)),
		.Blue:      Value(description: "Blue",       value: Color.color(240, saturation: 1)),
		.Purple:    Value(description: "Purple",     value: Color.color(280, saturation: 1)),
		.Pink:      Value(description: "Pink",       value: Color.color(320, saturation: 1)),
	]

	static func valueForKey(key: Key) -> Value {
		return Dictionary[key]!
	}
}
