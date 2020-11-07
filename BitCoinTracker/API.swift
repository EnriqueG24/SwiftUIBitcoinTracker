//
//  Data.swift
//  BitCoinTracker
//
//  Created by Enrique Gongora on 9/8/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import SwiftUI

// Observable object makes the class observable
class Api: ObservableObject {
    
    // Published is whenever something changes, it notifies all of the listeners
    @Published var currencyCode: [String] = []
    @Published var buyingPrice: [Double] = []
    @Published var symbolArray: [String] = []
    
    init() {
        fetchCryptoData { (bitcoin) in
            switch bitcoin {
            case .success(let currency):
                currency.forEach { (currencies) in
                    DispatchQueue.main.async {
                        self.currencyCode.append(currencies.key)
                        self.symbolArray.append(currencies.value.symbol)
                        self.buyingPrice.append(currencies.value.buy)
                    }
                }
            case .failure(let error):
                print("Failed to fetch courses", error)
            }
        }
    }
    
    func fetchCryptoData(completion: @escaping (Result<Bitcoin, Error>) -> ()) {
        guard let url = URL(string: "https://blockchain.info/ticker") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let safeData = data else { return }
            
            do {
                let bitcoin = try JSONDecoder().decode(Bitcoin.self, from: safeData)
                completion(.success(bitcoin))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

struct API_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
