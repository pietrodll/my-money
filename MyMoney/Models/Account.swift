//
//  Account.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/5/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import Foundation

struct Account: Hashable, Codable, Identifiable {
    let id: String
    let name: String
}

extension Account {
    init(id: String) {
        self.id = id
        self.name = "Unknown"
    }
}
