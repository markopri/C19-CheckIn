//
//  LoginState.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import Foundation

enum LoginState {
	case loading
	case success
	case failed(String)
}
