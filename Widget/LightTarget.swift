import Cocoa

class LightTarget: NSObject {
	let label: String
	let color: LIFXHTTP.Light.Color
	var on: Bool
	var brightness: Double

	private let client: LIFXHTTP.Client
	private let selector: String

	init(client: LIFXHTTP.Client, selector: String, label: String, color: LIFXHTTP.Light.Color, on: Bool, brightness: Double) {
		self.client = client
		self.selector = selector
		self.label = label
		self.color = color
		self.on = on
		self.brightness = brightness
	}
}
