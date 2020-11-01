//
//  IntroCoordinator.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 31/10/2020.
//

import Foundation
import UIKit

protocol IntroCoordinatorDelegate: class {
	func selectedAppMode(_ selectedAppMode: ApplicationModeType)
}

class IntroCoordinator: RootViewCoordinator {
	var childCoordinators: [Coordinator] = []

	var rootViewController: UIViewController {
		return self.navigationController
	}

	private lazy var navigationController: UINavigationController = {
		let navigationController = UINavigationController()
		navigationController.modalPresentationStyle = .fullScreen
		UINavigationBar.appearance().tintColor = UIColor.black
		UINavigationBar.appearance().barTintColor = UIColor.white
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

		return navigationController
	}()

	weak var delegate: IntroCoordinatorDelegate?

	init() {
		
	}

	//MARK: Functions
	func startSelectAppMode() {
		let selectAppModeViewController = SelectAppModeViewController()
		selectAppModeViewController.delegate = self
		self.navigationController.viewControllers = [selectAppModeViewController]
	}

	func startLogin() {
		let loginViewController = LoginViewController()
		loginViewController.delegate = self
		self.navigationController.viewControllers = [loginViewController]
	}
}

//MARK: Extensions
extension IntroCoordinator: SelectAppModeControllerDelegate {
	func selectedAppMode(appMode: ApplicationModeType) {
		delegate?.selectedAppMode(appMode)
	}
}

extension IntroCoordinator: LoginControllerDelegate {
	func loginSuccess() {
		//TODO: add protocol of intro coordinator which will be handled in app coordinator
	}

	func registrationDidTap() {
		let registrationViewController = RegistrationViewController()
		registrationViewController.delegate = self
		self.navigationController.pushViewController(registrationViewController, animated: true)
	}
}

extension IntroCoordinator: RegistrationControllerDelegate {
	func registrationSuccess() {
		self.navigationController.popToRootViewController(animated: true)
	}
}
