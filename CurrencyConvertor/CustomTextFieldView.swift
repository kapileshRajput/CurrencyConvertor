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
    var title: String
    var numberFormatter: NumberFormatter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 15))
            
            TextField(
                "",
                value: $amount,
                formatter: numberFormatter)
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
    CustomTextFieldView(
        amount: .constant(1.0),
        currency: .constant(.Indian),
        title: "Sample Title",
        numberFormatter: NumberFormatter()
    )
}
