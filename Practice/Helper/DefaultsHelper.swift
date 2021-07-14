//
//  DefaultsHelper.swift
//  Practice
//
//  Created by Cypress on 7/9/21.
//

import Foundation

class DefaultsHelper {
    
    enum Key: String {
        case onboardingSeen
    }
    
    var isOnboardingSeen: Bool {
        UserDefaults.standard.bool(forKey: Key.onboardingSeen.rawValue)
    }
    
    func setOnboarding(isSeen: Bool) {
        UserDefaults.standard.set(isSeen, forKey: Key.onboardingSeen.rawValue)
    }
}
