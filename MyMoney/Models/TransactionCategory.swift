//
//  TransactionCategory.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/7/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

struct TransactionCategory: Hashable, Codable, Identifiable {
    let id: String
    let name: String
}
