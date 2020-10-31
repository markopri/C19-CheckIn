//
//  LoadingViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 31/10/2020.
//

import Foundation
import UIKit

public class LoadingViewController: UIViewController {
	private lazy var activityIndicator = UIActivityIndicatorView(style: .white)
	private let mainWindow = UIApplication.shared.keyWindow
	private var isLoadingViewPresented = false

	private lazy var loadingWindow: UIWindow = {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.backgroundColor = UIColor.clear
		window.rootViewController = UIViewController()
		window.windowLevel = .statusBar

		return window
	}()

	override public func viewDidLoad() {
		super.viewDidLoad()
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.scale(factor: 2)
		view.addSubview(activityIndicator)

		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}

	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//We use a 0.5 second delay to not show an activity indicator in case our data loads very quickly
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
			self?.activityIndicator.startAnimating()
		}
	}

	public func showLoadingView() {
		if !isLoadingViewPresented {
			loadingWindow.makeKeyAndVisible()
			self.modalPresentationStyle = .fullScreen
			loadingWindow.rootViewController?.present(self, animated: false, completion: nil)
		}

		isLoadingViewPresented = true
	}

	public func hideLoadingView() {
		self.mainWindow?.makeKeyAndVisible()
		self.presentingViewController?.dismiss(animated: false, completion: nil)
		loadingWindow.isHidden = true
		isLoadingViewPresented = false
	}
}

extension UIActivityIndicatorView {
	func scale(factor: CGFloat) {
		guard factor > 0.0 else { return }

		transform = CGAffineTransform(scaleX: factor, y: factor)
	}
}
