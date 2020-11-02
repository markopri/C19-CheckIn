//
//  HomeViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

protocol HomeViewControllerDelegate: class {
	func goToCheckOut(deviceName: String)
}

import UIKit
import CoreBluetooth

class HomeViewController: BaseViewController {
	@IBOutlet weak var btnSelectRoom: UIButton!
	@IBOutlet weak var btnCheckIn: UIButton!

	private var bluetoothManager: BluetoothManager
	weak var delegate: HomeViewControllerDelegate?
	var scannedDevices: Dictionary<UUID, String> = [:]
	var scannedDeviceNames: [String] = []
	var selectedDeviceName: String = ""

	init(bluetoothManager: BluetoothManager) {
		self.bluetoothManager = bluetoothManager
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
		bluetoothManager.delegate = self
		bluetoothManager.startScanning()
	}


	//MARK: Layout
	func setupLayout() {
		btnSelectRoom.addRounded(backgroundColor: UIColor(named: "button_background_secondary")!, titleColor: UIColor(named: "button_tint_primary")!)
		if selectedDeviceName == "" {
			btnSelectRoom.setTitle("Select room", for: .normal)
		} else {
			btnSelectRoom.setTitle(selectedDeviceName, for: .normal)
		}

		btnCheckIn.addRounded(backgroundColor: UIColor(named: "button_background_primary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnCheckIn.setTitle("Check In", for: .normal)
	}


	//MARK: Button actions
	@IBAction func btnSelectRoomTapped(_ sender: UIButton) {
		let selectDeviceViewController = SelectDeviceViewController(scannedDeviceNames: scannedDeviceNames)
		selectDeviceViewController.delegate = self
		self.navigationController?.pushViewController(selectDeviceViewController, animated: true)
	}

	@IBAction func btnCheckInTapped(_ sender: UIButton) {
		if selectedDeviceName == "" {
			let alert = UIAlertController(title: "Info", message: "Please select room before proceeding", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

			self.present(alert, animated: true, completion: nil)
		} else {
			delegate?.goToCheckOut(deviceName: selectedDeviceName)
		}
	}
}

extension HomeViewController: SelectDeviceViewControllerDelegate {
	func confirmSelectedDeviceDidTap(name: String) {
		selectedDeviceName = name
		self.navigationController?.popViewController(animated: true)
	}
}

extension HomeViewController: BluetoothManagerDelegate {
	func peripheralsDidUpdate() {
		print(bluetoothManager.peripherals.mapValues{$0.name})
		scannedDevices.removeAll()
		scannedDeviceNames.removeAll()
		scannedDevices = bluetoothManager.peripherals.mapValues{($0.name ?? "Unknown name")}

		for dev in scannedDevices {
			scannedDeviceNames.append(dev.value)
		}
	}
}
