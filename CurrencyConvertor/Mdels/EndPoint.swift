//
//  EndPoint.swift
//  CurrencyConvertor
//
//  Created by Kapilesh Rajput on 26/05/25.
//


import Foundation

enum EndPoint {
    case latestJson
    
    var value: String {
        switch self {
        case .latestJson:
            "/latest.json"
        }
    }
}
