//
//  APIManager.swift
//  CurrencyConvertor
//
//  Created by Kapilesh Rajput on 24/05/25.
//

import Foundation

struct APIService {
    static let shared: APIService = APIService()
    
    private let baseURL: String
    private let appId: String
    
    private init() {
        self.baseURL = AppConfig.value(for: .apiBaseURL)
        self.appId = AppConfig.value(for: .apiKey)
    }
    
    func getLatestRates() async -> Result<Rates, APIError> {
        let urlString = "\(baseURL)\(EndPoint.latestJson.value)?app_id=\(appId)"
        
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let result = try JSONDecoder().decode(Rates.self, from: data)
            return .success(result)
        } catch let decodingError as DecodingError {
            return .failure(.decodingFailed(decodingError))
        } catch {
            return .failure(.networkError(error))
        }
    }
}
