//
//  ContentView.swift
//  BitCoinTracker
//
//  Created by Enrique Gongora on 9/7/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var api = Api()
    @State private var pickerSelection = 0
    @State private var amount: String = ""
    
    var total: Double {
        guard api.buyingPrice.count > 0 else {
            return 0
        }
        let buyingPrice = api.buyingPrice[pickerSelection]
        let amountInDouble = Double(amount) ?? 0.0
        let totalAmount = buyingPrice * amountInDouble
        return totalAmount
    }
    
    var symbol: String {
        guard api.symbolArray.count > 0 else {
            return ""
        }
        let currentSymbol = api.symbolArray[pickerSelection]
        return currentSymbol
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(symbol)\(total, specifier: "%.2f")")
                .font(.system(size: 30))
            
            Spacer()
            
            TextField("Enter Amount:", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()
            Picker("", selection: $pickerSelection) {
                ForEach(0..<api.currencyCode.count) {
                    let currency = api.currencyCode[$0]
                    Text(currency)
                }
            }
            .id(UUID())
            .labelsHidden()
        }.padding()
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
