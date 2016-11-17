//
//  Preferences.swift
//  TySimulator
//
//  Created by luckytianyiyan on 2016/11/17.
//  Copyright © 2016年 luckytianyiyan. All rights reserved.
//

import Cocoa
import MASPreferences

class Preferences {
    static let kUserDefaultsKeyPreferences = "com.tianyiyan.preferences"
    private static let sharedPreferencesWindowController: MASPreferencesWindowController = preferencesWindowController()
    
    static func sharedWindowController() -> MASPreferencesWindowController {
        return sharedPreferencesWindowController
    }
    
    static var onlyAvailableDevices: Bool {
        get {
            let preferences: Dictionary<String, Any> = Preferences.preferences()
            if let onlyAvailableDevices = preferences["onlyAvailableDevices"] {
                return onlyAvailableDevices as! Bool
            } else {
                return true
            }
        }
        
        set {
            var preferences: Dictionary<String, Any> = Preferences.preferences()
            preferences["onlyAvailableDevices"] = newValue
            UserDefaults.standard.set(preferences, forKey: kUserDefaultsKeyPreferences)
            UserDefaults.standard.synchronize()
            log.verbose("update preferences: \(preferences)")
        }
    }
    
    static func preferences() -> Dictionary<String, Any> {
        if let preferences = UserDefaults.standard.dictionary(forKey: kUserDefaultsKeyPreferences) {
            return preferences
        } else {
            return Dictionary()
        }
    }
    
    private class func preferencesWindowController() -> MASPreferencesWindowController {
        let generalViewController = GeneralPreferencesViewController()
        let preferencesWindow = MASPreferencesWindowController(viewControllers: [generalViewController], title: "Preferences")
        return preferencesWindow!
    }
}