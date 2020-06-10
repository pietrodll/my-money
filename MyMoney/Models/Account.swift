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

extension Account: FirestoreEntity {
    init(fromFirestore data: [String: Any], id: String) throws {
        guard let name = data["name"] as? String else {
            throw InstanciationError(collection: "accounts", className: "Account", causedBy: data)
        }

        self.id = id
        self.name = name
    }

    func toFirestore() -> [String: Any] {
        return ["name": name]
    }
}
