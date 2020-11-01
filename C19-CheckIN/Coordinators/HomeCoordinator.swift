//
//  HomeCoordinator.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import Foundation
import UIKit

class HomeCoordinator: NSObject, RootViewCoordinator {
	var childCoordinators: [Coordinator] = []
	var rootViewController: UIViewController

	private var navigationController: UINavigationController {
		return self.rootViewController as! UINavigationController
	}

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	func start() {
		let homeViewController = HomeViewController()
		homeViewController.delegate = self
		navigationController.pushViewController(homeViewController, animated: true)
	}
}

extension HomeCoordinator: HomeViewControllerDelegate {
	func goToCheckOut() {
		let checkoOutViewController = CheckInViewController()
		navigationController.pushViewController(checkoOutViewController, animated: true)
	}
}
