//
//  SwitchCurrenciesButtonView.swift
//  CurrencyConvertor
//
//  Created by Kapilesh Rajput on 22/05/25.
//


import SwiftUI

struct SwitchCurrenciesButtonView: View {
    
    @Binding var firstCurrency: CurrencyChoice
    @Binding var secondCurrency: CurrencyChoice
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button {
            let tempCurrencyChoiceHolder = firstCurrency
            firstCurrency = secondCurrency
            secondCurrency = tempCurrencyChoiceHolder
            action?()
        } label: {
            HStack {
                Spacer()
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
            }
        }
        .clipShape(.circle)
        .padding(.vertical)
        .foregroundStyle(.black)
        
    }
}


#Preview {
    SwitchCurrenciesButtonView(
        firstCurrency: .constant(.Indian),
        secondCurrency: .constant(.Usa)
    )
}
