//
//  UserFirestoreService.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/24/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import Foundation

protocol UserFirestoreService: FirestoreService {
    var userId: String? { get set }
}

extension UserFirestoreService {
    var userCollection: String {
        "users/\(self.userId!)/\(Self.collectionName)"
    }

    // MARK: Create

    func create(newItem: Item, completion: @escaping (Result<String, FirestoreError>) -> Void) {
        if userId != nil {
            self.create(collection: userCollection, newItem: newItem, completion: completion)
        } else {
            completion(.failure(UndefinedUserError(collection: Self.collectionName)))
        }
    }

    func create(newItem: Item,
                serverTimestampField: String,
                completion: @escaping (Result<String, FirestoreError>) -> Void) {
        if userId != nil {
            self.create(collection: userCollection,
                        newItem: newItem,
                        serverTimestampField: serverTimestampField,
                        completion: completion)
        } else {
            completion(.failure(UndefinedUserError(collection: Self.collectionName)))
        }
    }

    func create(newItemWithId: Item, completion: @escaping (Result<String, FirestoreError>) -> Void) {
        if userId != nil {
            self.create(collection: userCollection, newItemWithId: newItemWithId, completion: completion)
        } else {
            completion(.failure(UndefinedUserError(collection: Self.collectionName)))
        }
    }

    func create(newItemWithId: Item,
                serverTimestampField: String,
                completion: @escaping (Result<String, FirestoreError>) -> Void) {
        if userId != nil {
            self.create(collection: userCollection,
                        newItemWithId: newItemWithId,
                        serverTimestampField: serverTimestampField,
                        completion: completion)
        } else {
            completion(.failure(UndefinedUserError(collection: Self.collectionName)))
        }
    }

    // MARK: Get

    func get(id: String, completion: @escaping (Result<Item, FirestoreError>) -> Void) {
        if userId != nil {
            self.get(collection: userCollection, id: id, completion: completion)
        } else {
            completion(.failure(UndefinedUserError(collection: Self.collectionName)))
        }
    }

    // MARK: Update

    func update(updated: Item, completion: @escaping (Result<Void, FirestoreError>) -> Void) {
        if userId != nil {
            self.update(collection: userCollection, updated: updated, completion: completion)
        } else {
            completion(.failure(UndefinedUserError(collection: Self.collectionName)))
        }
    }

    // MARK: List

    func list(completion: @escaping (Result<[Item], FirestoreError>) -> Void) {
        if userId != nil {
            self.list(collection: userCollection, completion: completion)
        } else {
            completion(.failure(UndefinedUserError(collection: Self.collectionName)))
        }
    }
}
