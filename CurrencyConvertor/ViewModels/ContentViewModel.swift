//
//  ContentViewModel.swift
//  CurrencyConvertor
//
//  Created by Kapilesh Rajput on 22/05/25.
//

import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    @Published var baseAmount: Double = 1.0
    @Published var convertedAmount: Double = 1.0
    @Published var baseCurrency: CurrencyChoice = .Usa
    @Published var convertedCurrency: CurrencyChoice = .Indian
    @Published var fetchedRates: Rates?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var conversionRate: Double {
        if let rates = fetchedRates,
           let baseExchangeRate = rates.rates[baseCurrency.rawValue],
           let convertedExchangeRate = rates.rates[convertedCurrency.rawValue] {
            return convertedExchangeRate / baseExchangeRate
        }
        
        return 1
    }
    
    func getLatestRates() async {
        await MainActor.run { self.isLoading = true }
        let result = await APIService.shared.getLatestRates()
        
        switch result {
        case .success(let rates):
            await MainActor.run {
                self.fetchedRates = rates
                self.isLoading = false
            }
        case .failure(let error):
            switch error {
            case .invalidURL:
                print("Invalid URL")
            case .decodingFailed(let decodingError):
                print("Decoding error: \(decodingError)")
            case .networkError(let networkError):
                print("Network error: \(networkError)")
            }
            // Not showing user the technical error but something generic and easy to understand.
            await MainActor.run {
                self.errorMessage = "Could not fetch rates."
            }
        }
    }
    
    func convert() {
        // Formula: (ConversionRate / BaseExchangeRate * BaseAmount = Conversion)
        
        if let rates = fetchedRates,
           let baseExchangeRate = rates.rates[baseCurrency.rawValue],
           let convertedExchangeRate = rates.rates[convertedCurrency.rawValue] {
                self.convertedAmount = (
                    convertedExchangeRate / baseExchangeRate
                ) * self.baseAmount
        }
    }
}
