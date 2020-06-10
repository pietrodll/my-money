//
//  Currency.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/5/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import Foundation

enum Currency: String, Codable, Hashable, CaseIterable, Identifiable {
    case USD
    case EUR
    case SGD

    var symbol: String {
        switch self {
            case .EUR:
                return "€"
            case .USD:
                return "$"
            case .SGD:
                return "S$"
        }
    }

    var id: String {
        self.rawValue
    }
}
