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

	private var navigationController: UINavigationController {
		return self.rootViewController as! UINavigationController
	}

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	func start() {
		let homeViewController = DeviceHomeViewController()
		navigationController.pushViewController(homeViewController, animated: true)
	}
}
