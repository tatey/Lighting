import Cocoa

class LightTargetManager {
	var lightTargets: [LightTarget]
	private let client: LIFXHTTP.Client

	init() {
		self.lightTargets = []
		self.client = LIFXHTTP.Client(accessToken: "")
	}

	func update(success: () -> Void, failure: () -> Void) {
		self.client.lights({ (lights: [LIFXHTTP.Light]) -> Void in
			self.lightTargets = lights.map({ (light: LIFXHTTP.Light) -> LightTarget in
				return LightTarget(
					client: self.client,
					selector: "id:\(light.id)",
					label: light.label,
					color: NSColor(
						hue: CGFloat(light.color.hue),
						saturation: CGFloat(light.color.saturation),
						brightness: CGFloat(light.brightness),
						alpha: 1.0
					),
					on: light.on,
					brightness: light.brightness
				)
			})
			success()
		}, failure: { () -> Void in
			failure()
		})
	}
}
