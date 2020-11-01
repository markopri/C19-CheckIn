//
//  SettingsViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

protocol SettingsViewControllerDelegate: class {
	func settingsOptionDidTap(optionType: SettingsCellType)
}

import UIKit

class SettingsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!

	var cellModels: [Any] = []
	weak var delegate: SettingsViewControllerDelegate?

	init() {
		super.init(isTabBarHidden: false, isUsingBLE: false, isUsingNetwork: true)
		setupCellModel()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
	}


	//MARK: Layout
	private func setupCellModel() {
		cellModels.removeAll()

		cellModels.append(SettingsCellModel(title: "Language", icon: "ic_language", type: .language))
		cellModels.append(SettingsCellModel(title: "Account details", icon: "ic_account_details", type: .accountDetails))
		cellModels.append(SettingsCellModel(title: "Sign out", icon: "ic_sign_out", type: .signOut))
	}

	//MARK: TableView Delegate/DS
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
		let model = cellModels[indexPath.row] as! SettingsCellModel
		cell.setup(model)

		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 55
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedCell = cellModels[indexPath.row] as! SettingsCellModel
		if selectedCell.type == .signOut {
			delegate?.settingsOptionDidTap(optionType: selectedCell.type)
		} else {
			let alert = UIAlertController(title: "Info", message: "Option have not been implemented yet.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

			self.present(alert, animated: true, completion: nil)
		}
	}
}
