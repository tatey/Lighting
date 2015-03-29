import Cocoa

class LIFXHTTP {
	class Client {
		let accessToken: String

		init(accessToken: String) {
			self.accessToken = accessToken
		}

		func lights(success: (lights: [Light]) -> Void, failure: () -> Void) {
			let url = NSURL(string: "https://api.lifx.com/v1beta1/lights/all")!
			let request = NSMutableURLRequest(URL: url)
			request.HTTPMethod = "GET"
			request.addValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")

			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
				if let httpResponse = response as? NSHTTPURLResponse {
					if httpResponse.statusCode == 200 {
						var jsonError: NSError?
						let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [NSDictionary]
						if jsonError == nil && jsonData != nil {
							let lights = jsonData!.reduce([]) { (lights: [Light], lightData: NSDictionary) -> [Light] in
								if let light = Light.parseWithJSONData(lightData) {
									return lights + [light]
								}
								return lights
							}
							success(lights: lights)
						} else {
							failure()
						}
					} else {
						failure()
					}
				}
			}
		}

		func setLightsPower(selector: String, on: Bool, success: (results: [Result]) -> Void, failure: () -> Void) {

		}

		func setLightsBrightness(selector: String, brightness: Double, success: (results: [Result]) -> Void, failure: () -> Void) {
			
		}
	}

	struct Result {
		enum Status: String {
			case OK = "ok"
			case TimedOut = "timed_out"
			case Offline = "offline"
		}

		let id: String
		let status: Status
	}

	struct Light {
		struct Color {
			let hue: Double
			let saturation: Double
			let kelvin: Int

			static func parseWithJSONData(data: NSDictionary) -> Color? {
				if let hue = data["hue"] as? Double {
					if let saturation = data["saturation"] as? Double {
						if let kelvin = data["kelvin"] as? Int {
							return Color(
								hue: hue,
								saturation: saturation,
								kelvin: kelvin
							)
						}
					}
				}
				return nil
			}
		}

		let id: String
		let label: String
		let on: Bool
		let brightness: Double
		let color: Color

		static func parseWithJSONData(data: NSDictionary) -> Light? {
			if let id = data["id"] as? String {
				if let label = data["label"] as? String {
					if let rawPower = data["power"] as? String {
						if let brightness = data["brightness"] as? Double {
							if let rawColor = data["color"] as? NSDictionary {
								if let color = Color.parseWithJSONData(rawColor) {
									return Light(
										id: id,
										label: label,
										on: rawPower == "on",
										brightness: brightness,
										color: color
									)
								}
							}
						}
					}
				}
			}
			return nil;
		}
	}
}
