//
//  LoginManager.swift
//  My360iDevApp
//
//  Created by Florian Harr on 8/21/21.
//

import Foundation
import SwiftUI

class LoginManager: ObservableObject {
    @Published var loggedInUser: String?
    
    @discardableResult
    func login(username: String, password: String) -> Bool {
        loggedInUser = username
        
        return true
    }
}
