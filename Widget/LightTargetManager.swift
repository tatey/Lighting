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
				LightTarget(
					client: self.client,
					selector: "id:\(light.id)",
					label: light.label,
					color: light.color,
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
