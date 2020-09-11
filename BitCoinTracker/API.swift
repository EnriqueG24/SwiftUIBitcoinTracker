//
//  Data.swift
//  BitCoinTracker
//
//  Created by Enrique Gongora on 9/8/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import SwiftUI

struct BitCoin: Decodable {
    let buy: Double
    let symbol: String
}

typealias BitCoinData = [String : BitCoin]

// Observable object makes the class observable
class Api: ObservableObject {
    
    // Published is whenever something changes, it notifies all of the listeners
    @Published var currencyCode: [String] = []
    @Published var buyingPrice: [Double] = []
    
    init() {
        self.fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://www.blockchain.info/ticker") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let safeData = data else { return }
                do {
                    let bitcoin = try JSONDecoder().decode(BitCoinData.self, from: safeData)
                    for (key, value) in bitcoin {
                        DispatchQueue.main.async {
                            self.currencyCode.append(key)
                            self.buyingPrice.append(value.buy)
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

struct API_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
