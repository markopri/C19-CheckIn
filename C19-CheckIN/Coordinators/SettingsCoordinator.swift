//
//  SettingsCoordinator.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import Foundation
import UIKit

class SettingsCoordinator: NSObject, RootViewCoordinator {
	var childCoordinators: [Coordinator] = []
	var rootViewController: UIViewController

	private var navigationController: UINavigationController {
		return self.rootViewController as! UINavigationController
	}

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	func start() {
		let settingsViewController = SettingsViewController()
		navigationController.pushViewController(settingsViewController, animated: true)
	}
}
