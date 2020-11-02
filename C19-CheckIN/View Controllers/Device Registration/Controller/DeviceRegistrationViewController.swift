//
//  DeviceRegistrationViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

public protocol DeviceRegistrationControllerDelegate: class {
	func deviceRegistrationSuccess()
}

import UIKit

class DeviceRegistrationViewController: BaseViewController, UITextFieldDelegate {
	@IBOutlet weak var txtDeviceName: UITextField!
	@IBOutlet weak var btnRegisterDevice: UIButton!

	private var logicController = DeviceRegistrationLogicController()
	public weak var delegate: DeviceRegistrationControllerDelegate?

	init() {
		super.init(isUsingBLE: false, isUsingNetwork: true)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		txtDeviceName.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
		setupLayout()
	}


	//MARK: Layout
	func setupLayout() {
		btnRegisterDevice.addRounded(backgroundColor: UIColor(named: "button_background_primary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnRegisterDevice.setTitle("Register device", for: .normal)

		txtDeviceName.layer.cornerRadius = 8.0
		txtDeviceName.attributedPlaceholder = NSAttributedString(string: "Enter device name",
									 attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "button_background_primary")])
	}


	//MARK: Button actions
	@IBAction func btnRegisterDeviceTapped(_ sender: UIButton) {
		logicController.handleDeviceRegistration(name: txtDeviceName.text ?? "") { [weak self] state in
			self?.render(state)
		}
	}
}

private extension DeviceRegistrationViewController {
	func render(_ state: DeviceRegistrationState) {
		switch state {
			case .loading:
				loadingViewController.showLoadingView()
			case .success:
				loadingViewController.hideLoadingView()
				delegate?.deviceRegistrationSuccess()
			case .failed(let error):
				loadingViewController.hideLoadingView()
				let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

				self.present(alert, animated: true, completion: nil)
		}
	}
}
