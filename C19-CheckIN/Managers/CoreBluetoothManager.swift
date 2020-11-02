//
//  CoreBluetoothManager.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 02/11/2020.
//

protocol BluetoothManagerDelegate: AnyObject {
	func peripheralsDidUpdate()
}

protocol BluetoothManager {
	var peripherals: Dictionary<UUID, CBPeripheral> { get }
	var delegate: BluetoothManagerDelegate? { get set }
	func startAdvertising(with name: String)
	func startScanning()
}


import Foundation
import CoreBluetooth

class CoreBluetoothManager: NSObject, BluetoothManager {
	// MARK: - Public properties
	weak var delegate: BluetoothManagerDelegate?
	private(set) var peripherals = Dictionary<UUID, CBPeripheral>() {
		didSet {
			delegate?.peripheralsDidUpdate()
		}
	}

	// MARK: - Public methods
	func startAdvertising(with name: String) {
		self.name = name
		peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
	}

	func startScanning() {
		centralManager = CBCentralManager(delegate: self, queue: nil)
	}

	// MARK: - Private properties
	private var peripheralManager: CBPeripheralManager?
	private var centralManager: CBCentralManager?
	private var name: String?
}

extension CoreBluetoothManager: CBPeripheralManagerDelegate {
	func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
		if peripheral.state == .poweredOn {
			if peripheral.isAdvertising {
				peripheral.stopAdvertising()
			}

			let uuid = CBUUID(string: BluetoothService.serviceUUID)
			var advertisingData: [String : Any] = [
				CBAdvertisementDataServiceUUIDsKey: [uuid]
			]

			if let name = self.name {
				advertisingData[CBAdvertisementDataLocalNameKey] = name
			}
			self.peripheralManager?.startAdvertising(advertisingData)
		} else {
			#warning("handle other states")
		}
	}
}

extension CoreBluetoothManager: CBCentralManagerDelegate {
	func centralManagerDidUpdateState(_ central: CBCentralManager) {
		if central.state == .poweredOn {

			if central.isScanning {
				central.stopScan()
			}

			let uuid = CBUUID(string: BluetoothService.serviceUUID)
			central.scanForPeripherals(withServices: [uuid])
		} else {
			#warning("Error handling")
		}
	}

	func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
		peripherals[peripheral.identifier] = peripheral
	}
}

