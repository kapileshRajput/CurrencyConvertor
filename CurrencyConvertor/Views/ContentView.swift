//
//  ContentView.swift
//  CurrencyConvertor
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    
    @FocusState var baseAmountIsFocused: Bool
    @FocusState var convertedAmountIsFocused: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                    Text(viewModel.errorMessage)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.red)
                    Spacer()
                }
                
                CustomTextFieldView(
                    amount: $viewModel.baseAmount, currency: $viewModel.baseCurrency, isFocused: $baseAmountIsFocused, title: "Amount",
                    numberFormatter: viewModel.numberFormatter, currencyChangeOperation:  {
                        viewModel.convert()
                    })
                
                SwitchCurrenciesButtonView(
                    firstCurrency: $viewModel.baseCurrency,
                    secondCurrency: $viewModel.convertedCurrency) {
                        viewModel.convert()
                    }
                
                CustomTextFieldView(
                    amount: $viewModel.convertedAmount, currency: $viewModel.convertedCurrency, isFocused: $convertedAmountIsFocused, title: "Converted To",
                    numberFormatter: viewModel.numberFormatter, currencyChangeOperation:  {
                        viewModel.convert()
                    }
                )
                
                HStack {
                    Spacer()
                    Text(
                        "1.000000 \(viewModel.baseCurrency.rawValue) = \(viewModel.conversionRate) \(viewModel.convertedCurrency.rawValue)"
                    )
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 25)
                    Spacer()
                }
                
            }
            .padding(.horizontal)
            .task {
                await viewModel.getLatestRates()
                viewModel.convert()
            }
            
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .tint(.white)
                }
            }
        }
        .onTapGesture {
            viewModel.convert()
            baseAmountIsFocused = false
            convertedAmountIsFocused = false
        }
    }
}

#Preview {
    ContentView()
}
