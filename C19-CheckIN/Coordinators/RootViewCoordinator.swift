//
//  RootViewCoordinator.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 30/10/2020.
//

import Foundation
import UIKit

public protocol RootViewControllerProvider: class {
	///The coordinators 'rootViewController'. It helps to think of this as the view controller that can be used to dismiss the coordinator from the view hierarchy
	var rootViewController: UIViewController { get }
}

///A Coordinator type that provides a root UIViewController
public typealias RootViewCoordinator = Coordinator & RootViewControllerProvider

