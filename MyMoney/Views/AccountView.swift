//
//  AccountView.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/6/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    @State private var error: String?

    @EnvironmentObject private var session: SessionStore

    func handleSignOut() {
        let success = session.signOut()
        if success {
            error = nil
        } else {
            error = "Error during sign out"
        }
    }

    var body: some View {
        VStack {
            Text("Account settings").font(.title)
            Button(action: handleSignOut) {
                Text("Sign out")
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView().environmentObject(SessionStore())
    }
}
