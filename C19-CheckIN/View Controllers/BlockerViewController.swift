//
//  BlockerViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 31/10/2020.
//

import Foundation
import UIKit

public enum BlockerViewControllerType {
	case ble
	case network
}

public class BlockerViewController: UIViewController {
	private let mainWindow = UIApplication.shared.keyWindow
	private var imageView = UIImageView()
	private var titleLabel = UILabel()
	private var isPresentedBle = false
	private var isPresentedNetwork = false

	private lazy var blockerWindow: UIWindow = {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.backgroundColor = .clear
		window.rootViewController = UIViewController()
		window.windowLevel = .statusBar

		return window
	}()

	override public func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(named: "background_primary")
		view.alpha = 0.9

		titleLabel.textColor = .white
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		imageView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(imageView)
		view.addSubview(titleLabel)

		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
		NSLayoutConstraint.activate([
			imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -30)
		])
	}

	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	public func showBlockerViewController(type: BlockerViewControllerType) {
		if !isPresentedBle && !isPresentedNetwork {
			blockerWindow.makeKeyAndVisible()
			self.modalPresentationStyle = .fullScreen
			blockerWindow.rootViewController?.present(self, animated: false, completion: nil)
		}

		switch type {
		case .ble:
			titleLabel.text = "NO BLUETOOTH"
			imageView.image = UIImage(named: "ic_bluetooth")
			isPresentedBle = true
		case .network:
			titleLabel.text = "NO NETWORK"
			imageView.image = UIImage(named: "ic_network")
			isPresentedNetwork = true
		}
	}

	public func hideBlockerViewController(type: BlockerViewControllerType) {
		switch type {
		case .ble:
			isPresentedBle = false
		case .network:
			isPresentedNetwork = false
		}

		if isPresentedNetwork {
			titleLabel.text = "NO NETWORK"
			imageView.image = UIImage(named: "ic_network")
		} else if isPresentedBle {
			titleLabel.text = "NO BLUETOOTH"
			imageView.image = UIImage(named: "ic_bluetooth")
		} else {
			self.mainWindow?.makeKeyAndVisible()
			self.presentingViewController?.dismiss(animated: false, completion: nil)
			blockerWindow.isHidden = true
		}
	}
}
