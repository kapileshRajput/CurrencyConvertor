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
    
    /*
     Note:
     1. This is a version of URLSession which allows us to make request and receive response as a completion handeler.
     2. We get the JSON by serializing the "data" and casting it to [String: Any]
     */
    func getLatestExchangeRates() {
        let urlString = "\(baseURL)\(EndPoint.latestJson.value)?app_id=\(appId)"
        print("urlString: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error: Failed to create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(
            with: urlRequest) { data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    print("Error: Invalid data")
                    return
                }
                
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]  else {
                        print("Error: Failed to serialize JSON data")
                        return
                    }
                    
                    print("Json: \(json)")
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        
        task.resume()
    }
}
