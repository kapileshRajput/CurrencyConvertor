//
//  APIManager.swift
//  CurrencyConvertor
//
//  Created by Kapilesh Rajput on 24/05/25.
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

struct APIManager {
    static let shared: APIManager = APIManager()
    
    private let baseURL: String
    private let appId: String
    
    private init() {
        self.baseURL = AppConfig.value(for: .apiBaseURL)
        self.appId = AppConfig.value(for: .apiKey)
    }
    
    func getLatestRates() async {
        let urlString = "\(baseURL)\(EndPoint.latestJson.value)?app_id=\(appId)"
        print("urlString: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error: Failed to create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        print("FIRST")
        
        do {
            
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
            print("SECOND")
            
            let result = try JSONDecoder().decode(Rates.self, from: data)
            
            if let inrRate = result.rates["INR"] {
                print("INR rate: \(inrRate)")
            }
            
            print("THIRD")
             
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
