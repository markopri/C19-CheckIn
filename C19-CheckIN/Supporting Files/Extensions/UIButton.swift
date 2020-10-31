//
//  UIButton.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 31/10/2020.
//

import Foundation
import UIKit

extension UIButton {
	public func addRounded(radius: CGFloat = 8.0, backgroundColor: UIColor, titleColor: UIColor) {
		self.layer.cornerRadius = radius
		self.backgroundColor = backgroundColor
		self.setTitleColor(titleColor, for: .normal)
	}
}
