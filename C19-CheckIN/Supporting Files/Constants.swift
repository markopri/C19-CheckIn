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


public struct BluetoothService {
	public static let serviceUUID = "4DF91029-B356-463E-9F48-BAB077BF3EF5"
}

public struct DateConstants {
	public static let dateFormat = "dd.MM.yyyy HH:mm"
}
