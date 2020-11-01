//
//  RegistrationViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

public protocol RegistrationControllerDelegate: class {
	func registrationSuccess()
}

import UIKit

class RegistrationViewController: BaseViewController, UITextFieldDelegate {
	@IBOutlet weak var txtName: UITextField!
	@IBOutlet weak var txtEmail: UITextField!
	@IBOutlet weak var btnRegister: UIButton!

	private var logicController = RegistrationLogicController()
	public weak var delegate: RegistrationControllerDelegate?

	init() {
		super.init(isUsingBLE: false, isUsingNetwork: true)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		txtName.delegate = self
		txtEmail.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
		setupLayout()
	}


	//MARK: Layout
	func setupLayout() {
		btnRegister.addRounded(backgroundColor: UIColor(named: "button_background_primary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnRegister.setTitle("Register", for: .normal)

		txtName.layer.cornerRadius = 8.0
		txtEmail.layer.cornerRadius = 8.0
	}


	//MARK: Button actions
	@IBAction func btnRegisterTapped(_ sender: UIButton) {
		logicController.handleRegistration(name: txtName.text ?? "", email: txtEmail.text ?? "") { [weak self] state in
			self?.render(state)
		}
	}
}

private extension RegistrationViewController {
	func render(_ state: RegistrationState) {
		switch state {
			case .loading:
				loadingViewController.showLoadingView()
			case .success:
				loadingViewController.hideLoadingView()
				delegate?.registrationSuccess()
			case .failed(let error):
				loadingViewController.hideLoadingView()
				let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

				self.present(alert, animated: true, completion: nil)
		}
	}
}
