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

	private var bluetoothManager: BluetoothManager

	init(bluetoothManager: BluetoothManager) {
		self.bluetoothManager = bluetoothManager
		super.init(isUsingBLE: false, isUsingNetwork: true)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let deviceName = UserDefaults.standard.value(forKey: UserDefaultsKey.kEnteredDeviceName) as! String
		bluetoothManager.startAdvertising(with: deviceName)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
		setupLayout()
	}


	//MARK: Layout
	func setupLayout() {
		let deviceName = UserDefaults.standard.value(forKey: UserDefaultsKey.kEnteredDeviceName) as! String
		lblDeviceName.text = deviceName
		lblCurrentUSerNumber.text = ""
	}


}
