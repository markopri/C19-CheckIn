//
//  HistoryCellModel.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import Foundation

struct HistoryCellModel {
	let roomTitle: String
	let startTime: String
	let endTime: String
	let duration: String

	init(roomTitle: String, startTime: String, endTime: String, duration: String) {
		self.roomTitle = roomTitle
		self.startTime = startTime
		self.endTime = endTime
		self.duration = duration
	}
}
