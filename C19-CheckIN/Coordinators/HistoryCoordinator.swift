//
//  HistoryCoordinator.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import Foundation
import UIKit

class HistoryCoordinator: NSObject, RootViewCoordinator {
	var childCoordinators: [Coordinator] = []
	var rootViewController: UIViewController

	private var navigationController: UINavigationController {
		return self.rootViewController as! UINavigationController
	}

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	func start() {
		let historyViewController = HistoryViewController()
		navigationController.pushViewController(historyViewController, animated: true)
	}
}
