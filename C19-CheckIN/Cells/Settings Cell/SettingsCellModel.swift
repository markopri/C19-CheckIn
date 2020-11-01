//
//  SettingsCellModel.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import Foundation

enum SettingsCellType {
	case signOut
	case language
	case accountDetails
}

struct SettingsCellModel {
	let title: String
	let icon: String
	let type: SettingsCellType

	init(title: String, icon: String, type: SettingsCellType) {
		self.title = title
		self.icon = icon
		self.type = type
	}
}
