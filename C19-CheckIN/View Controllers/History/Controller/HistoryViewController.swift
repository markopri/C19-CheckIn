//
//  HistoryViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import UIKit

class HistoryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!

	var cellModels: [Any] = []

	init() {
		super.init(isTabBarHidden: false, isUsingBLE: false, isUsingNetwork: true)
		setupCellModel()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
	}


	//MARK: Layout
	private func setupCellModel() {
		cellModels.removeAll()

		cellModels.append(HistoryCellModel(roomTitle: "Room 1", startTime: "1.1.2020 11:15:00", endTime: "1.1.2020 12:00:00", duration: "45 min"))
		cellModels.append(HistoryCellModel(roomTitle: "Room 3", startTime: "2.1.2020 11:15:00", endTime: "2.1.2020 12:00:00", duration: "45 min"))
		cellModels.append(HistoryCellModel(roomTitle: "Room 44", startTime: "3.1.2020 11:15:00", endTime: "3.1.2020 12:00:00", duration: "45 min"))
	}


	//MARK: TableView Delegate/DS
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell
		let model = cellModels[indexPath.row] as! HistoryCellModel
		cell.setup(model)

		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 124
	}
}
