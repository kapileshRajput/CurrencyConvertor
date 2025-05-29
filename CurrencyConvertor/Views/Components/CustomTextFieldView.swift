//
//  CustomTextFieldView.swift
//  CurrencyConvertor
//
//  Created by Kapilesh Rajput on 22/05/25.
//


import SwiftUI

struct CustomTextFieldView: View {
    
    @Binding var amount: Double
    @Binding var currency: CurrencyChoice
    var isFocused: FocusState<Bool>.Binding
    
    var title: String
    var numberFormatter: NumberFormatter
    var onSubmit: (() -> Void)? = nil
    var currencyChangeOperation: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 15))
            
            TextField(
                "",
                value: $amount,
                formatter: numberFormatter)
            .focused(isFocused)
            .onSubmit {
                onSubmit?()
            }
            .font(.system(size: 18, weight: .semibold))
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1)
            }
            .overlay(alignment: .trailing) {
                HStack {
                    currency.image()
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(.circle)
                    
                    Menu {
                        ForEach(CurrencyChoice.allCases) { currencyChoice in
                            Button(currencyChoice.fetchMenuName()) {
                                currency = currencyChoice
                                currencyChangeOperation?()
                            }
                        }
                    } label: {
                        Text(currency.rawValue)
                        Image(systemName: "chevron.down")
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.black)
                    
                }
                .padding(.trailing)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var amount: Double = 1.0
        @State private var currency: CurrencyChoice = .Indian
        @FocusState private var isTextFieldFocused: Bool
        
        var body: some View {
            CustomTextFieldView(
                amount: $amount,
                currency: $currency,
                isFocused: $isTextFieldFocused,
                title: "Sample Title",
                numberFormatter: NumberFormatter()
            )
        }
    }
    
    return PreviewWrapper()
}
