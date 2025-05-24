//
//  AppConfig.swift
//  CurrencyConvertor
//
//  Created by Kapilesh Rajput on 24/05/25.
//

import Foundation

enum AppConfigKey: String {
    case apiBaseURL = "API_BASE_URL"
    case apiKey = "API_KEY"
}

struct AppConfig {
    
    /// Fetches a value from Info.plist using a typed key
    static func value(for key: AppConfigKey) -> String {
        guard let value = Bundle.main.infoDictionary?[key.rawValue] as? String else {
            fatalError("Missing value for \(key.rawValue) in Info.plist")
        }
        return value
    }
    
    /// Optional version if you don't want to crash
    static func optionalValue(for key: AppConfigKey) -> String? {
        return Bundle.main.infoDictionary?[key.rawValue] as? String
    }
}
