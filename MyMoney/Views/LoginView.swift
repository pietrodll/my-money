//
//  Login.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/5/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionStore

    @State private var email = ""
    @State private var password = ""
    @State private var loading = false
    @State private var error = false

    func handleSignin() {
        loading = true
        error = false
        session.signIn(email: email, password: password) { _, error in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }

    var body: some View {
        VStack {
            Text("Login").font(.title)
            HStack(alignment: .center) {
                Image(systemName: "dollarsign.circle.fill")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .foregroundColor(.blue)
            }
            Form {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                SecureField("Password", text: $password)
                Button(action: handleSignin) {
                    Text("Sign in")
                }
            }

            if error {
                Text("An error occurred!")
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionStore())
    }
}
