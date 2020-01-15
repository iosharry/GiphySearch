//
//  String+.swift
//  GiphySearch
//
//  Created by gwangyonglee on 2020/01/14.
//  Copyright © 2020 gwangyonglee. All rights reserved.
//

import UIKit

extension String {
	func CGFloatValue() -> CGFloat? {
		guard let doubleValue = Double(self) else {
			return nil
		}
		return CGFloat(doubleValue)
	}
}
