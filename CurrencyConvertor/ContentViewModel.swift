//
//  ContentViewModel.swift
//  CurrencyConvertor
//
//  Created by Kapilesh Rajput on 22/05/25.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var baseAmount: Double = 1.0
    @Published var convertedAmount: Double = 1.0
    @Published var baseCurrency: CurrencyChoice = .Indian
    @Published var convertedCurrency: CurrencyChoice = .Indian
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
