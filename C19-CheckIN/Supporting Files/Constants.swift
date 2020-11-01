//
//  Constants.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 30/10/2020.
//

import Foundation

public struct UserDefaultsKey {
	public static let kIsSelectedModeType = "isSelectedModeType"
	public static let kSelectedApplicationModeType = "selectedApplicationModeType"
	public static let kEnteredDeviceName = "enteredDeviceName"
	public static let kUsername = "username"
}

public struct NotificationEvent {
	public static let networkPowerChange = "networkPowerChange"
}
