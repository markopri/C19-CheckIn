//
//  BaseViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 31/10/2020.
//

import Foundation
import UIKit
import CoreBluetooth

class BaseViewController: UIViewController, CBCentralManagerDelegate {
	let loadingViewController = LoadingViewController()
	let blockerViewController = BlockerViewController()
	let blockerNotification = NotificationCenter.default
	var isTabBarHidden = true
	var isUsingBLE: Bool
	var isUsingNetwork: Bool
	var bleManager: CBCentralManager

	public init(isTabBarHidden: Bool = true, isUsingBLE: Bool = true, isUsingNetwork: Bool = true) {
		self.isUsingBLE = isUsingBLE
		self.isUsingNetwork = isUsingNetwork
		bleManager = CBCentralManager()
		super.init(nibName: nil, bundle: nil)
		bleManager.delegate = self
		self.isTabBarHidden = isTabBarHidden
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tabBarController?.tabBar.isHidden = isTabBarHidden
		configureNavigationBar()
		setupBackgroundColor()

		let appDelegate = UIApplication.shared.delegate as? AppDelegate
		if (isUsingNetwork) {
			if let reachability = appDelegate?.reachability {
				if reachability.connection == .unavailable {
					blockerViewController.showBlockerViewController(type: .network)
				}
				blockerNotification.addObserver(self, selector: #selector(networkStatusChanged), name: Notification.Name.reachabilityChanged, object: reachability)
			}
		}
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		blockerNotification.removeObserver(self)
	}

	func setupNavigation(barTintColor: UIColor, textColor: UIColor) {
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.backgroundColor = barTintColor
		self.navigationController?.navigationBar.tintColor = textColor
		self.navigationController?.navigationBar.barTintColor = barTintColor
		if barTintColor == UIColor(named: "background_primary") {
			self.navigationController?.navigationBar.isTranslucent = false
		}

		self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = textColor
		self.navigationItem.leftBarButtonItem?.tintColor = textColor
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]
		setNeedsStatusBarAppearanceUpdate()
	}

	func setupBackgroundColor(color: UIColor? = UIColor(named: "background_primary")) {
		self.view.backgroundColor = color
	}

	//MARK: Private functions
	private func configureNavigationBar() {
		let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 240, height: 40))
		let logoImageView = UIImageView(image: UIImage(named: "logo"))
		titleView.addSubview(logoImageView)
		logoImageView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
		logoImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
		logoImageView.contentMode = .scaleAspectFit

		self.navigationItem.titleView = titleView
	}

	@objc func dismissKeyboard() {
		view.endEditing(true)
	}

	@objc func networkStatusChanged(notification: Notification) {
		guard let reachability = notification.object as? Reachability else { return }

		if reachability.connection != .unavailable {
			DispatchQueue.main.async { [weak self] in
				self?.blockerViewController.hideBlockerViewController(type: .network)
			}
		} else {
			DispatchQueue.main.async { [weak self] in
				self?.blockerViewController.showBlockerViewController(type: .network)
			}
		}
	}

	//CBCentralManager Delegate
	func centralManagerDidUpdateState(_ central: CBCentralManager) {
		if (isUsingBLE) {
			switch central.state {
			case .poweredOn:
				DispatchQueue.main.async { [weak self] in
					self?.blockerViewController.hideBlockerViewController(type: .ble)
				}
			case .poweredOff:
				DispatchQueue.main.async { [weak self] in
					self?.blockerViewController.showBlockerViewController(type: .ble)
				}
			default:
				break
			}
		}
	}
	
}
