//
//  DeviceHomeCoordinator.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import Foundation
import UIKit

class DeviceHomeCoordinator: NSObject, RootViewCoordinator {
	var childCoordinators: [Coordinator] = []
	var rootViewController: UIViewController
	var bluetoothManager: BluetoothManager

	private var navigationController: UINavigationController {
		return self.rootViewController as! UINavigationController
	}

	init(rootViewController: UIViewController, bluetoothManager: BluetoothManager) {
		self.rootViewController = rootViewController
		self.bluetoothManager = bluetoothManager
	}

	func start() {
		let homeViewController = DeviceHomeViewController(bluetoothManager: bluetoothManager)
		navigationController.pushViewController(homeViewController, animated: true)
	}
}
