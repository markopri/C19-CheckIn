//
//  CheckInViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import UIKit

class CheckInViewController: BaseViewController {
	@IBOutlet weak var lblRoomName: UILabel!
	@IBOutlet weak var lblDuration: UILabel!
	@IBOutlet weak var lblStartTime: UILabel!
	@IBOutlet weak var btnCheckOut: UIButton!

	init() {
		super.init(isTabBarHidden: true, isUsingBLE: false, isUsingNetwork: true)
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
		self.navigationItem.setHidesBackButton(true, animated: true)
	}


	//MARK: Layout
	func setupLayout() {
		btnCheckOut.addRounded(backgroundColor: UIColor(named: "button_background_primary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnCheckOut.setTitle("Check out", for: .normal)
	}


	//MARK: Button actions
	@IBAction func btnCheckOutTapped(_ sender: UIButton) {
	}
}
