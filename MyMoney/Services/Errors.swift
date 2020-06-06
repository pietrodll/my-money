//
//  Errors.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/5/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import Foundation

class FirestoreError: Error {
    let collection: String
    let message: String
    let error: Error?
    
    init(collection: String, message: String, error: Error) {
        self.collection = collection
        self.message = message
        self.error = error
    }

    init(collection: String, message: String) {
        self.collection = collection
        self.message = message
        self.error = nil
    }
}


class NotFoundError: FirestoreError {
    let id: String
    
    init(collection: String, id: String) {
        let message = "Document not found: \(id)"
        self.id = id
        super.init(collection: collection, message: message)
    }
}

class InstanciationError: FirestoreError {
    let className: String
    let causedBy: [String: Any]

    init(collection: String, className: String, causedBy data: [String: Any]) {
        self.className = className
        self.causedBy = data
        let message = "Error during instanciation of \(className) from document of collection \(collection)"
        super.init(collection: collection, message: message)
    }
}
