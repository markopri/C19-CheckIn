//
//  DeviceRegistrationLogicController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import Foundation
import UIKit

class DeviceRegistrationLogicController {
	typealias Handler = (DeviceRegistrationState) -> Void

	func handleDeviceRegistration(name: String, then handler: @escaping Handler) {
		handler(.loading)

		if (name == "") {
			handler(.failed("You need to enter device name to proceed"))
		} else {
			UserDefaults.standard.set(name, forKey: UserDefaultsKey.kEnteredDeviceName)
			UserDefaults.standard.synchronize()

			handler(.success)
		}
	}
}
