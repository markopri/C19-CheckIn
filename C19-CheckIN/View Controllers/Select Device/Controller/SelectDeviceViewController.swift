//
//  SelectDeviceViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

protocol SelectDeviceViewControllerDelegate: class {
	func confirmSelectedDeviceDidTap()
}

import UIKit

class SelectDeviceViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var btnConfirm: UIButton!

	var cellModels: [Any] = []
	weak var delegate: SelectDeviceViewControllerDelegate?

	init() {
		super.init(isTabBarHidden: true, isUsingBLE: true, isUsingNetwork: true)
		setupCellModel()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(UINib(nibName: "SelectRoomCell", bundle: nil), forCellReuseIdentifier: "SelectRoomCell")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
	}


	//MARK: Layout
	private func setupCellModel() {
		cellModels.removeAll()

		cellModels.append(SelectRoomCellModel(title: "Room 1"))
		cellModels.append(SelectRoomCellModel(title: "Room 2"))
		cellModels.append(SelectRoomCellModel(title: "Room 3"))
		cellModels.append(SelectRoomCellModel(title: "Room 4"))
		cellModels.append(SelectRoomCellModel(title: "Room 5"))
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

	@IBAction func btnConfirmTapped(_ sender: UIButton) {
		delegate?.confirmSelectedDeviceDidTap()
	}
}
