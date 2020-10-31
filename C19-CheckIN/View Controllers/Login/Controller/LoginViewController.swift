//
//  LoginViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 31/10/2020.
//

import UIKit

class LoginViewController: BaseViewController {

	init() {
		super.init(isUsingBLE: false, isUsingNetwork: false)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
		setupLayout()
	}

	//MARK: Layout
	func setupLayout() {
		
	}

}
