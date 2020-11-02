//
//  CheckInViewController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//
protocol CheckInViewControllerDelegate: class {
	func goToHome()
}

import UIKit
import CoreData

class CheckInViewController: BaseViewController {
	@IBOutlet weak var lblRoomName: UILabel!
	@IBOutlet weak var lblDuration: UILabel!
	@IBOutlet weak var lblStartTime: UILabel!
	@IBOutlet weak var btnCheckOut: UIButton!

	weak var delegate: CheckInViewControllerDelegate?
	var selectedDeviceName: String
	var startTime: String
	var timer: Timer?

	init(selectedDeviceName: String, startTime: String) {
		self.selectedDeviceName = selectedDeviceName
		self.startTime = startTime
		super.init(isTabBarHidden: true, isUsingBLE: false, isUsingNetwork: true)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigation(barTintColor: UIColor(named: "background_primary")!, textColor: .white)
		setupLayout()
		runTimedCode()
		self.navigationItem.setHidesBackButton(true, animated: true)
	}


	//MARK: Layout
	func setupLayout() {
		lblRoomName.text = selectedDeviceName
		lblStartTime.text = "\(startTime)"
		lblDuration.text  = ""

		btnCheckOut.addRounded(backgroundColor: UIColor(named: "button_background_primary")!, titleColor: UIColor(named: "button_tint_primary")!)
		btnCheckOut.setTitle("Check out", for: .normal)
	}


	//MARK: Button actions
	@IBAction func btnCheckOutTapped(_ sender: UIButton) {
		timer?.invalidate()

		let appDelegate = UIApplication.shared.delegate as? AppDelegate
		let managedContext = appDelegate!.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Visit", in: managedContext)
		let visit = NSManagedObject(entity: entity!, insertInto: managedContext)

		visit.setValue(selectedDeviceName, forKey: "roomName")
		visit.setValue(startTime, forKey: "startTime")
		visit.setValue(Date().string(format: DateConstants.dateFormat), forKey: "endTime")
		visit.setValue(lblDuration.text, forKey: "duration")

		do {
			try managedContext.save()
			delegate?.goToHome()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}


	//MARK: Timer function
	@objc public func runTimedCode() {
		let currentTime = Date().string(format: DateConstants.dateFormat)

		let formatter = DateFormatter()
		formatter.dateFormat = DateConstants.dateFormat

		let date1 = formatter.date(from: startTime)!
		let date2 = formatter.date(from: currentTime)!

		let elapsedTime = date2.timeIntervalSince(date1)

		// convert from seconds to hours, rounding down to the nearest hour
		let hours = floor(elapsedTime / 60 / 60)

		// we have to subtract the number of seconds in hours from minutes to get
		// the remaining minutes, rounding down to the nearest minute (in case you
		// want to get seconds down the road)
		let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)

		print("\(Int(hours)) hr and \(Int(minutes)) min")
		lblDuration.text = "Duration: \(Int(hours)) h \(Int(minutes)) min"
	}
}
