//
//  LoginViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 31/10/2020.
//

public protocol LoginControllerDelegate: class {
	func loginSuccess()
	func registrationDidTap()
}

import UIKit

class LoginViewController: BaseViewController, UITextFieldDelegate {
	@IBOutlet weak var txtUniqueId: UITextField!
	@IBOutlet weak var btnLogin: UIButton!
	@IBOutlet weak var btnRegister: UIButton!

	private var logicController = LoginLogicController()
	public weak var delegate: LoginControllerDelegate?

	init() {
		super.init(isUsingBLE: false, isUsingNetwork: true)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		txtUniqueId.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
		setupLayout()
	}


	//MARK: Layout
	func setupLayout() {
		btnLogin.addRounded(backgroundColor: UIColor(named: "button_background_primary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnLogin.setTitle("Login", for: .normal)

		btnRegister.setTitle("Register".uppercased(), for: .normal)

		txtUniqueId.layer.cornerRadius = 8.0
	}


	//MARK: Button actions
	@IBAction func btnLoginTapped(_ sender: UIButton) {
		logicController.handleLogin(uniqueId: txtUniqueId.text ?? "") { [weak self] state in
			self?.render(state)
		}
	}

	@IBAction func btnRegisterTapped(_ sender: UIButton) {
		delegate?.registrationDidTap()
	}
}

private extension LoginViewController {
	func render(_ state: LoginState) {
		switch state {
			case .loading:
				loadingViewController.showLoadingView()
			case .success:
				loadingViewController.hideLoadingView()
				delegate?.loginSuccess()
			case .failed(let error):
				loadingViewController.hideLoadingView()
				let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

				self.present(alert, animated: true, completion: nil)
		}
	}
}
