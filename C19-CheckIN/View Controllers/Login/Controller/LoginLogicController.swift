//
//  LoginLogicController.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import Foundation
import UIKit

class LoginLogicController {
	typealias Handler = (LoginState) -> Void

	func handleLogin(uniqueId: String, then handler: @escaping Handler) {
		handler(.loading)

		if (uniqueId == "") {
			handler(.failed("You need to enter unique ID to proceed"))
		} else {
			//TODO: Send entered id to BE -> check if it is valid, then continue
			UserDefaults.standard.set(uniqueId, forKey: UserDefaultsKey.kUsername)
			UserDefaults.standard.synchronize()

			handler(.success)
		}
	}
}
