//
//  RegistrationLogicController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import Foundation
import UIKit

class RegistrationLogicController {
	typealias Handler = (RegistrationState) -> Void

	func handleRegistration(name: String, email: String, then handler: @escaping Handler) {
		handler(.loading)

		if (name == "" || email == "") {
			handler(.failed("You need to enter name and email to proceed"))
		} else {
			//TODO: need to do check if user exists
			//TODO: add generation of unique id
		}

		handler(.success)
	}
}
