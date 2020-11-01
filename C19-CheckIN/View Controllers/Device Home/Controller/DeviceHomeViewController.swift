//
//  DeviceHomeViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import UIKit

class DeviceHomeViewController: BaseViewController {
	@IBOutlet weak var lblDeviceName: UILabel!
	@IBOutlet weak var lblCurrentUSerNumber: UILabel!

	init() {
		super.init(isUsingBLE: false, isUsingNetwork: true)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
		setupLayout()
	}


	//MARK: Layout
	func setupLayout() {
		//TODO: Add device name and current number of users
	}


}
