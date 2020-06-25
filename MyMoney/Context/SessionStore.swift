//
//  SessionStore.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/6/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

class SessionStore: ObservableObject {
    @Published var session: MyMoneyUser?

    private var handler: AuthStateDidChangeListenerHandle?
    private var userService = UserService.getInstance()

    // MARK: Auth listener

    func listen() {
        handler = Auth.auth().addStateDidChangeListener { _, user in
            if let user = user {
                self.userService.get(id: user.uid) { result in
                    switch result {
                        case let .success(mmUser):
                            self.session = mmUser
                            self.initServices(userId: mmUser.id)
                        case .failure:
                            self.session = nil
                    }
                }
            } else {
                self.session = nil
            }
        }
    }

    func unbind() {
        if let handler = handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }

    // MARK: Auth methods

    func signUp(email: String,
                password: String,
                name: String,
                completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { auth, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.userService.create(fromAuth: auth!, name: name, completion: completion)
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { auth, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let userId = auth!.user.uid
                completion(.success(userId))
            }
        }
    }

    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }

    // MARK: Services

    private func initServices(userId: String) {
        TransactionService.getInstance().userId = userId
        AccountService.getInstance().userId = userId
    }
}
