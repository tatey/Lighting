//
//  Created by Tate Johnson on 26/07/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import AppKit
import LIFXHTTPKit

extension Color {
	// Based on https://github.com/LIFX/LIFXKit/blob/master/LIFXKit/Extensions/Categories-UIKit/UIColor+LFXExtensions.m
	// which was based on http://www.tannerhelland.com/4435/convert-temperature-rgb-algorithm-code/
	public func toNSColor() -> NSColor {
		if isWhite {
			var red: Float = 0.0
			var green: Float = 0.0
			var blue: Float = 0.0

			if kelvin <= 6600 {
				red = 1.0
			} else {
				red = Float(1.292936186062745) * powf(Float(kelvin) / Float(100.0) - Float(60.0), Float(-0.1332047592))
			}

			if kelvin <= 6600 {
				green = Float(0.39008157876902) * logf(Float(kelvin) / Float(100.0)) - Float(0.631841443788627)
			} else {
				green = Float(1.129890860895294) * powf(Float(kelvin) / Float(100.0) - Float(60.0), Float(-0.0755148492))
			}

			if kelvin >= 6600 {
				blue = 1.0
			} else {
				if kelvin <= 1900 {
					blue = 0.0
				} else {
					blue = Float(0.543206789110196) * logf(Float(kelvin) / Float(100.0) - Float(10.0)) - Float(1.19625408914)
				}
			}

			if red < 0.0 {
				red = 0.0
			} else if red > 1.0 {
				red = 1.0
			}
			if green < 0.0 {
				green = 0.0
			} else if green > 1.0 {
				green = 1.0
			}
			if blue < 0.0 {
				blue = 0.0
			} else if blue > 1.0 {
				blue = 1.0
			}

			return NSColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
		} else {
			return NSColor(hue: CGFloat(hue) / 360.0, saturation: CGFloat(saturation), brightness: 1.0, alpha: 1.0)
		}
	}
}
