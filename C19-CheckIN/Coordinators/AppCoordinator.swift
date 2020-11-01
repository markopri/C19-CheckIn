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
			let selectedModeType = UserDefaults.standard.value(forKey: UserDefaultsKey.kSelectedApplicationModeType) as! String
			if selectedModeType == ApplicationModeType.admin.rawValue {
				if UserDefaults.standard.object(forKey: UserDefaultsKey.kEnteredDeviceName) != nil {
					showDeviceHome()
				} else {
					showDeviceRegistrationViewController()
				}
			} else {
				if UserDefaults.standard.object(forKey: UserDefaultsKey.kUsername) != nil {
					showUserHome()
				} else {
					showLoginViewController()
				}
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

	func showDeviceHome() {
		self.rootViewController = UINavigationController()
		self.window.rootViewController = self.rootViewController
		let homeCoordinator = DeviceHomeCoordinator(rootViewController: rootViewController)
		homeCoordinator.start()
		self.addChildCoordinator(homeCoordinator)
	}

	func showUserHome() {
		let tabViewController = UITabBarController()
		tabViewController.tabBar.unselectedItemTintColor = .white
		tabViewController.tabBar.tintColor = .white
		UITabBar.appearance().selectionIndicatorImage = getImageWithColorPosition(color: UIColor(named: "button_background_primary")!, size: CGSize(width:30,height: 22), lineSize: CGSize(width:30, height:3))

		let homeViewController = HomeViewController()
		let homeTab = newTab(rootVC: homeViewController, tabImage: "ic_home", tag: Tab.home.rawValue)
		let homeCoordinator = HomeCoordinator(rootViewController: homeTab)
		addChildCoordinator(homeCoordinator)

		let historyViewController = HistoryViewController()
		let historyTab = newTab(rootVC: historyViewController, tabImage: "ic_history", tag: Tab.history.rawValue)
		let historyCoordinator = HistoryCoordinator(rootViewController: historyTab)
		addChildCoordinator(historyCoordinator)

		let settingsViewController = SettingsViewController()
		let settingsTab = newTab(rootVC: settingsViewController, tabImage: "ic_settings", tag: Tab.settings.rawValue)
		let settingsCoordinator = HistoryCoordinator(rootViewController: settingsTab)
		addChildCoordinator(settingsCoordinator)

		tabViewController.viewControllers = [homeTab, historyTab, settingsTab]
		self.rootViewController = tabViewController
		tabViewController.selectedIndex = Tab.home.rawValue
		self.window.rootViewController = self.rootViewController
	}

	private func newTab(rootVC: UIViewController, tabImage: String, tag: Int) -> UINavigationController {
		let navVC = UINavigationController()
		navVC.viewControllers = [rootVC]
		navVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:tabImage), tag: tag)
		navVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -6, right: 0)
		return navVC
	}
	
	private func getImageWithColorPosition(color: UIColor, size: CGSize, lineSize: CGSize) -> UIImage {
		let rect = CGRect(x:0, y: 0, width: size.width, height: size.height)
		let rectLine = CGRect(x:0, y:size.height-lineSize.height,width: lineSize.width,height: lineSize.height)
		UIGraphicsBeginImageContextWithOptions(size, false, 0)
		UIColor.clear.setFill()
		UIRectFill(rect)
		color.setFill()
		UIRectFill(rectLine)
		let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return image
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

	func userLoginSuccess() {
		showUserHome()
	}

	func deviceRegistratiponSuccess() {
		showDeviceHome()
	}
}
