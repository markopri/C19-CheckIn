//
//  SelectDeviceViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

protocol SelectDeviceViewControllerDelegate: class {
	func confirmSelectedDeviceDidTap(name: String)
}

import UIKit

class SelectDeviceViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var btnConfirm: UIButton!

	var scannedDeviceNames: [String]
	var cellModels: [Any] = []
	weak var delegate: SelectDeviceViewControllerDelegate?
	var selectedDeviceName: String = ""

	init(scannedDeviceNames: [String]) {
		self.scannedDeviceNames = scannedDeviceNames
		super.init(isTabBarHidden: true, isUsingBLE: true, isUsingNetwork: true)
		setupCellModel()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupLayout()
		tableView.register(UINib(nibName: "SelectRoomCell", bundle: nil), forCellReuseIdentifier: "SelectRoomCell")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
	}


	//MARK: Layout
	private func setupLayout() {
		btnConfirm.addRounded(backgroundColor: UIColor(named: "button_background_primary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnConfirm.setTitle("Select room", for: .normal)
		btnConfirm.isEnabled = false
		btnConfirm.layer.opacity = 0.3
	}

	private func setupCellModel() {
		cellModels.removeAll()

		for device in scannedDeviceNames {
			cellModels.append(SelectRoomCellModel(title: device))
		}
	}

	//MARK: TableView Delegate/DS
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SelectRoomCell") as! SelectRoomCell
		let model = cellModels[indexPath.row] as! SelectRoomCellModel
		cell.setup(model)

		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 55
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedDeviceName = scannedDeviceNames[indexPath.row]
		btnConfirm.isEnabled = true
		btnConfirm.layer.opacity = 1.0
	}

	@IBAction func btnConfirmTapped(_ sender: UIButton) {
		delegate?.confirmSelectedDeviceDidTap(name: selectedDeviceName)
	}
}
