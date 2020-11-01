//
//  AppCoordinator.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 30/10/2020.
//

import Foundation
import UIKit

class AppCoordinator: RootViewCoordinator {
	var childCoordinators: [Coordinator] = []
	var selectAppModeCoordinator: IntroCoordinator
	var introCoordinator: IntroCoordinator

	let window: UIWindow
	var rootViewController: UIViewController = UINavigationController()

	public init(window: UIWindow) {
		self.window = window
		selectAppModeCoordinator = IntroCoordinator()
		introCoordinator = IntroCoordinator()

		self.window.rootViewController = rootViewController
		self.window.makeKeyAndVisible()
	}

	///Starts the coordinator
	public func start() {
		let isSelectedModeType = UserDefaults.standard.bool(forKey: UserDefaultsKey.kIsSelectedModeType)
		if isSelectedModeType {
			//TODO: add check if user is logged in or device name has been entered
			let selectedModeType = UserDefaults.standard.value(forKey: UserDefaultsKey.kSelectedApplicationModeType) as! String
			if selectedModeType == ApplicationModeType.admin.rawValue {
				showDeviceRegistrationViewController()
			} else {
				showLoginViewController()
			}
		} else {
			showSelectAppModeViewController()
		}
	}

	func showSelectAppModeViewController() {
		self.childCoordinators.removeAll()
		self.rootViewController = UINavigationController()
		self.window.rootViewController = self.rootViewController
		selectAppModeCoordinator.delegate = self
		selectAppModeCoordinator.startSelectAppMode()
		self.addChildCoordinator(selectAppModeCoordinator)
		self.rootViewController.present(selectAppModeCoordinator.rootViewController, animated: false, completion: nil)
	}

	func showLoginViewController() {
		self.childCoordinators.removeAll()
		self.rootViewController = UINavigationController()
		self.window.rootViewController = self.rootViewController
		introCoordinator.delegate = self
		introCoordinator.startLogin()
		self.addChildCoordinator(introCoordinator)
		self.rootViewController.present(introCoordinator.rootViewController, animated: false, completion: nil)
	}

	func showDeviceRegistrationViewController() {
		self.childCoordinators.removeAll()
		self.rootViewController = UINavigationController()
		self.window.rootViewController = self.rootViewController
		introCoordinator.delegate = self
		introCoordinator.startDeviceRegistration()
		self.addChildCoordinator(introCoordinator)
		self.rootViewController.present(introCoordinator.rootViewController, animated: false, completion: nil)
	}
}

extension AppCoordinator: IntroCoordinatorDelegate {
	func selectedAppMode(_ selectedAppMode: ApplicationModeType) {
		if selectedAppMode == .admin {
			showDeviceRegistrationViewController()
		} else {
			showLoginViewController()
		}
	}
}
