//
//  HomeViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

protocol HomeViewControllerDelegate: class {
	func goToCheckOut()
}

import UIKit

class HomeViewController: BaseViewController {
	@IBOutlet weak var btnSelectRoom: UIButton!
	@IBOutlet weak var btnCheckIn: UIButton!

	weak var delegate: HomeViewControllerDelegate?

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
		btnSelectRoom.addRounded(backgroundColor: UIColor(named: "button_background_secondary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnSelectRoom.setTitle("Select room", for: .normal)

		btnCheckIn.addRounded(backgroundColor: UIColor(named: "button_background_primary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnCheckIn.setTitle("Check In", for: .normal)
	}


	//MARK: Button actions
	@IBAction func btnSelectRoomTapped(_ sender: UIButton) {
		let selectDeviceViewController = SelectDeviceViewController()
		selectDeviceViewController.delegate = self
		self.navigationController?.pushViewController(selectDeviceViewController, animated: true)
	}

	@IBAction func btnCheckInTapped(_ sender: UIButton) {
		delegate?.goToCheckOut()
	}
}

extension HomeViewController: SelectDeviceViewControllerDelegate {
	func confirmSelectedDeviceDidTap() {
		//TODO: set name of room into button
		self.navigationController?.popViewController(animated: true)
	}
}
