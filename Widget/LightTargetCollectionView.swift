//
//  Created by Tate Johnson on 17/06/2015.
//  Copyright (c) 2015 Tate Johnson. All rights reserved.
//

import Cocoa

class LightTargetCollectionView: NSCollectionView {
	func sizeThatFits(size: NSSize) -> NSSize {
		let count = content.count
		if let itemPrototype = self.itemPrototype where count > 0 {
			let itemSize = itemPrototype.view.frame.size
			let itemsPerRow = floor(size.width / itemSize.width)
			let numberOfRows = Int(ceil(CGFloat(count) / itemsPerRow))
			return NSSize(width: itemSize.width * CGFloat(itemsPerRow), height: itemSize.height * CGFloat(numberOfRows))
		} else {
			return NSSize(width: 0.0, height: 0.0)
		}
	}
}
