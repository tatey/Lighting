//
//  Created by Tate Johnson on 30/08/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Foundation

struct BrightnessMap {
	enum Key {
		case percent100
		case percent80
		case percent60
		case percent40
		case percent20
	}

	class Value {
		let description: String
		let value: Double

		init(description: String, value: Double) {
			self.description = description
			self.value = value
		}
	}

	fileprivate static let Dictionary: [Key: Value] = [
		.percent100: Value(description: "100%", value: 1.0),
		.percent80:  Value(description: "80%",  value: 0.8),
		.percent60:  Value(description: "60%",  value: 0.6),
		.percent40:  Value(description: "40%",  value: 0.4),
		.percent20:  Value(description: "20%",  value: 0.2)
	]

	static func valueForKey(_ key: Key) -> Value {
		return Dictionary[key]!
	}
}
