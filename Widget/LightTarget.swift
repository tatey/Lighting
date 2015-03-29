import Cocoa

class LightTarget: NSObject {
	let label: String
	let color: LIFXHTTP.Light.Color
	var on: Bool {
		didSet {
			self.client.setLightsPower(self.selector, on: self.on, success: { (results) -> Void in
				// FIXME
			}) { () -> Void in
				// FIXME
			}
		}
	}
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
