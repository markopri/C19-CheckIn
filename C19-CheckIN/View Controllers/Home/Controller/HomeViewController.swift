//
//  HomeViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import UIKit

class HomeViewController: BaseViewController {
	@IBOutlet weak var btnSelectRoom: UIButton!
	@IBOutlet weak var btnCheckIn: UIButton!

	init() {
		super.init(isTabBarHidden: false, isUsingBLE: false, isUsingNetwork: true)
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


	//MARK: Button actions
	@IBAction func btnSelectRoomTapped(_ sender: UIButton) {
	}

	@IBAction func btnCheckInTapped(_ sender: UIButton) {
	}
	
}
