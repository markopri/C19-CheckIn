//
//  Coordinator.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 30/10/2020.
//

import Foundation

public protocol Coordinator: class {
	var childCoordinators: [Coordinator] { get set }
}

public extension Coordinator {
	func addChildCoordinator(_ childCoordinator: Coordinator) {
		self.childCoordinators.append(childCoordinator)
	}

	func removeChildCoordinator(_ childCoordinator: Coordinator) {
		self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
	}
}
