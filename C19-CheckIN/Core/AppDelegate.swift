//
//  AppDelegate.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 30/10/2020.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	static var window: UIWindow?
	var appCoordinator: AppCoordinator!
	var reachability: Reachability?

	private lazy var bluetoothManager = CoreBluetoothManager()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		AppDelegate.window = UIWindow(frame: UIScreen.main.bounds)
		self.appCoordinator = AppCoordinator(window: AppDelegate.window!, bluetoothManager: bluetoothManager)

		IQKeyboardManager.shared.enable = true

		reachability = try! Reachability()
		do {
			try reachability?.startNotifier()
		} catch {
			print("ERROR: Could not start reachability identifier")
		}

		self.appCoordinator.start()

		return true

	}

	func applicationWillResignActive(_ application: UIApplication) {
		
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		
	}

}

