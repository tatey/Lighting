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
							let lights = jsonData!.map({ (lightData: NSDictionary) -> Light in
								Light(
									id: "1",
									label: "Test 1",
									on: true,
									brightness: 0.0,
									color: LIFXHTTP.Light.Color(hue: 0, saturation: 0, kelvin: 0)
								)
							})
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
			let kelvin: Double
		}

		let id: String
		let label: String
		let on: Bool
		let brightness: Double
		let color: Color
	}
}
