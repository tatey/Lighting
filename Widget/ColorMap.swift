//
//  Created by Tate Johnson on 30/08/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Foundation

struct BrightnessMap {
	enum Key {
		case Percent100
		case Percent80
		case Percent60
		case Percent40
		case Percent20
	}

	class Value {
		let description: String
		let value: Double

		init(description: String, value: Double) {
			self.description = description
			self.value = value
		}
	}

	static func valueForKey(key: Key) -> Value {
		return dictionary[key]!
	}

	private static let dictionary: [Key: Value] = [
		.Percent100: Value(description: "100%", value: 1.0),
		.Percent80:  Value(description: "80%",  value: 0.8),
		.Percent60:  Value(description: "60%",  value: 0.6),
		.Percent40:  Value(description: "40%",  value: 0.4),
		.Percent20:  Value(description: "20%",  value: 0.2)
	]
}
