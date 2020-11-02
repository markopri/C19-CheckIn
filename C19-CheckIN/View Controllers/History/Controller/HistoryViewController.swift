//
//  HistoryViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import UIKit
import CoreData

class HistoryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!

	var cellModels: [Any] = []
	var databaseContent: [NSManagedObject] = []

	init() {
		super.init(isTabBarHidden: false, isUsingBLE: false, isUsingNetwork: true)
		//setupCellModel()
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

		let appDelegate = UIApplication.shared.delegate as? AppDelegate
		let managedContext = appDelegate!.persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Visit")

		do {
			databaseContent = try managedContext.fetch(fetchRequest)
			setupCellModel()
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
	}


	//MARK: Layout
	private func setupCellModel() {
		cellModels.removeAll()

		for data in databaseContent {
			cellModels.append(HistoryCellModel(roomTitle: data.value(forKey: "roomName") as? String ?? "", startTime: data.value(forKey: "startTime") as? String ?? "", endTime: data.value(forKey: "endTime") as? String ?? "", duration: data.value(forKey: "duration") as? String ?? ""))
		}
	}


	//MARK: TableView Delegate/DS
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell
		let model = cellModels[cellModels.count - 1 - indexPath.row] as! HistoryCellModel
		cell.setup(model)

		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 124
	}
}
