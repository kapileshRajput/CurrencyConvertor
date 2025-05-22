//
//  ContentView.swift
//  CurrencyConvertor
//
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount: String = ""
    @State private var conversionAmount: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Amount")
                .font(.system(size: 15))
            
            TextField("", text: $amount)
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 1)
                }
            
            HStack {
                Spacer()
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
            }
            .padding(.vertical)
            
            Text("Converted To")
                .font(.system(size: 15))
            
            TextField("", text: $conversionAmount)
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 1)
                }
            
            HStack {
                Spacer()
                Text("1.0000 USD = 2.00000 EUR")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 25)
                Spacer()
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
