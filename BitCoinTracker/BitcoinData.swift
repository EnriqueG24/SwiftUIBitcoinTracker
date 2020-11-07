//
//  BitcoinData.swift
//  BitCoinTracker
//
//  Created by Enrique Gongora on 11/6/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import Foundation

struct BitcoinData: Codable {
    let buy: Double
    let symbol: String
}

typealias Bitcoin = [String: BitcoinData]
