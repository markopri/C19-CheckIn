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
	var bluetoothManager: BluetoothManager

	private var navigationController: UINavigationController {
		return self.rootViewController as! UINavigationController
	}

	init(rootViewController: UIViewController, bluetoothManager: BluetoothManager) {
		self.rootViewController = rootViewController
		self.bluetoothManager = bluetoothManager
	}

	func start() {
		let homeViewController = HomeViewController(bluetoothManager: bluetoothManager)
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
