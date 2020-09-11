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
    
    var body: some View {
        VStack {
            Spacer()
            Text("Total")
                .font(.system(size: 30))
            Spacer()
            
            TextField("Enter Amount:", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            
            Picker("", selection: $pickerSelection) {
                    ForEach(self.api.currencyCode, id: \.self) { currency in
                        Text(currency)
                    }
            }.id(UUID())
                .labelsHidden()
        }.padding()
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
