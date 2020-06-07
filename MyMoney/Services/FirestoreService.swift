//
//  FirestoreService.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/5/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import Foundation
import Firebase

protocol FirestoreEntity {
    init(fromFirestore data: [String: Any], id: String) throws
    func toFirestore() -> [String: Any]
}

protocol FirestoreService {
    associatedtype Item: FirestoreEntity, Identifiable

    static var collectionName: String { get }
    static var db: Firestore? { get }

    static func getInstance() -> Self

    static func toModel(data: [String: Any], id: String) -> Item?
    static func toDict(model: Item) -> [String: Any]
}

extension FirestoreService {
    private static func createFirestoreError(_ message: String, _ error: Error?) -> FirestoreError {
        if let error = error {
            return FirestoreError(collection: Self.collectionName, message: message, error: error)
        }
        return FirestoreError(collection: Self.collectionName, message: message)
    }

    public func get(collection: String, id: String, completion: @escaping (Result<Item, FirestoreError>) -> Void) {
        let ref = Self.db?.collection(collection).document(id)

        ref?.getDocument { (document, error) in
            if let err = error {
                completion(.failure(Self.createFirestoreError("Error while getting document", err)))
                return
            }

            if let document = document, document.exists, let data = document.data() {
                do {
                    let item = try Item(fromFirestore: data, id: id)

                    completion(.success(item))
                } catch let err as InstanciationError {
                    completion(.failure(err))
                } catch {
                    completion(.failure(Self.createFirestoreError("Error while getting document", error)))
                }
            } else {
                completion(.failure(NotFoundError(collection: Self.collectionName, id: id)))
            }
        }
    }

    public func get(id: String, completion: @escaping (Result<Item, FirestoreError>) -> Void) {
        self.get(collection: Self.collectionName, id: id, completion: completion)
    }

    public func list(collection: String, completion: @escaping (Result<[Item], FirestoreError>) -> Void) {
        Self.db?.collection(collection).getDocuments { snapshot, err in
            if let err = err {
                completion(.failure(Self.createFirestoreError("Error while getting documents", err)))
                return
            }

            var result: [Item] = []

            for document in snapshot!.documents {
                do {
                    let data = document.data()
                    let item = try Item(fromFirestore: data, id: document.documentID)
                    result.append(item)
                } catch let error as InstanciationError {
                    completion(.failure(error))
                    return
                } catch {
                    completion(.failure(Self.createFirestoreError("Error while getting documents", error)))
                    return
                }
            }

            completion(.success(result))
        }
    }

    public func list(completion: @escaping (Result<[Item], FirestoreError>) -> Void) {
        self.list(collection: Self.collectionName, completion: completion)
    }

    public func update(collection: String,
                       updated: Item,
                       completion: @escaping (Result<Void, FirestoreError>) -> Void) {
        guard let itemId = updated.id as? String else {
            completion(.failure(Self.createFirestoreError("Invalid item to update", nil)))
            return
        }

        Self.db?.collection(collection).document(itemId).setData(updated.toFirestore()) { err in
            if let err = err {
                completion(.failure(Self.createFirestoreError("Error while updating document", err)))
            } else {
                completion(.success(()))
            }
        }
    }

    public func update(updated: Item, completion: @escaping (Result<Void, FirestoreError>) -> Void) {
        self.update(collection: Self.collectionName, updated: updated, completion: completion)
    }

    public func create(collection: String,
                       newItem: Item,
                       completion: @escaping (Result<String, FirestoreError>) -> Void) {
        var ref: DocumentReference?
        ref = Self.db?.collection(collection).addDocument(data: newItem.toFirestore()) { err in
            if let err = err {
                completion(.failure(Self.createFirestoreError("Error while adding document", err)))
            } else {
                completion(.success(ref!.documentID))
            }
        }
    }

    public func create(newItem: Item, completion: @escaping (Result<String, FirestoreError>) -> Void) {
        self.create(collection: Self.collectionName, newItem: newItem, completion: completion)
    }
}
