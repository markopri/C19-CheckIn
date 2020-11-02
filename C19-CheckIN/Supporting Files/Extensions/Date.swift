//
//  Date.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 02/11/2020.
//

import Foundation

extension Date {
	func string(format: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.string(from: self)
	}
}
