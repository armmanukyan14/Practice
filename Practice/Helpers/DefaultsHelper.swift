//
//  DefaultsHelper.swift
//  Practice
//
//  Created by Cypress on 7/9/21.
//

import Foundation

class DefaultsHelper {
    
    let standard = UserDefaults.standard
    
    enum Key: String {
        case onboardingSeen
        case logedIn
    }
    
    var isOnboardingSeen: Bool {
        UserDefaults.standard.bool(forKey: Key.onboardingSeen.rawValue)
    }
    
    var isLogedIn: Bool {
        UserDefaults.standard.bool(forKey: Key.logedIn.rawValue)
    }
    
    func setOnboarding(isSeen: Bool) {
        UserDefaults.standard.set(isSeen, forKey: Key.onboardingSeen.rawValue)
    }
    
    func setLogin(isSeen: Bool) {
        UserDefaults.standard.set(isSeen, forKey: Key.logedIn.rawValue)
    }
}
