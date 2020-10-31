//
//  SelectAppModeViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 31/10/2020.
//

import UIKit

public protocol SelectAppModeControllerDelegate: class {
	func selectedAppMode(appMode: ApplicationModeType)
}

class SelectAppModeViewController: BaseViewController {
	@IBOutlet weak var btnAdminMode: UIButton!
	@IBOutlet weak var btnUserMode: UIButton!

	public weak var delegate: SelectAppModeControllerDelegate?


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
		btnAdminMode.addRounded(backgroundColor: UIColor(named: "button_background_primary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnAdminMode.setTitle("Admin mode", for: .normal)

		btnUserMode.addRounded(backgroundColor: UIColor(named: "button_background_primary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnUserMode.setTitle("User mode", for: .normal)
	}


	//MARK: Button actions
	@IBAction func btnAdminModeTapped(_ sender: UIButton) {
		UserDefaults.standard.set(true, forKey: UserDefaultsKey.kIsSelectedModeType)
		UserDefaults.standard.set(ApplicationModeType.admin.rawValue, forKey: UserDefaultsKey.kSelectedApplicationModeType)
		UserDefaults.standard.synchronize()

		delegate?.selectedAppMode(appMode: .admin)
	}

	@IBAction func btnUserModeTapped(_ sender: UIButton) {
		UserDefaults.standard.set(true, forKey: UserDefaultsKey.kIsSelectedModeType)
		UserDefaults.standard.set(ApplicationModeType.user.rawValue, forKey: UserDefaultsKey.kSelectedApplicationModeType)
		UserDefaults.standard.synchronize()

		delegate?.selectedAppMode(appMode: .user)
	}
}
