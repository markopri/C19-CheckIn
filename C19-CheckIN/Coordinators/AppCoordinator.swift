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

	let window: UIWindow
	var rootViewController: UIViewController = UINavigationController()

	public init(window: UIWindow) {
		self.window = window
		self.window.rootViewController = rootViewController
		self.window.makeKeyAndVisible()
	}

	///Starts the coordinator
	public func start() {
		let isSelectedModeType = UserDefaults.standard.bool(forKey: UserDefaultsKey.kIsSelectedModeType)
		if isSelectedModeType {
			//TODO: determine which user type is and depending on that show right screen
		} else {
			//TODO: go to screen to select mode in which application will work
		}
		self.rootViewController = UINavigationController(rootViewController: ViewController())
		UIApplication.shared.windows.first?.rootViewController = self.rootViewController
	}
}
