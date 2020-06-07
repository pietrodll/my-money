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
    @Published var session: User?
    var handler: AuthStateDidChangeListenerHandle?

    // MARK: Auth listener

    func listen() {
        handler = Auth.auth().addStateDidChangeListener { _, user in
            if let user = user {
                self.session = User(id: user.uid, email: user.email, displayName: user.displayName)
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

    func signUp(email: String, password: String, completion: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }

    func signIn(email: String, password: String, completion: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
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
}
