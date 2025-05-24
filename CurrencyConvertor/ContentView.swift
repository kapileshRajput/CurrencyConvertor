//
//  ContentView.swift
//  CurrencyConvertor
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomTextFieldView(
                amount: $viewModel.baseAmount, currency: $viewModel.baseCurrency, title: "Amount",
                numberFormatter: viewModel.numberFormatter
            )
            
            SwitchCurrenciesButtonView(
                firstCurrency: $viewModel.baseCurrency,
                secondCurrency: $viewModel.convertedCurrency
            )
            
            CustomTextFieldView(
                amount: $viewModel.convertedAmount, currency: $viewModel.convertedCurrency, title: "Converted To",
                numberFormatter: viewModel.numberFormatter
            )
            
            HStack {
                Spacer()
                Text("1.0000 USD = 2.00000 EUR")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 25)
                Spacer()
            }
            
        }
        .padding(.horizontal)
        .onAppear {
            APIManager.shared.getLatestExchangeRates()
        }
    }
}

#Preview {
    ContentView()
}
