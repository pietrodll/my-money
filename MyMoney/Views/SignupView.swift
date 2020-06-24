//
//  SignupView.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/9/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var session: SessionStore

    @Binding var show: Bool

    @State private var loading = false
    @State private var success = false
    @State private var error: String?
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    func handleSignUp() {
        if password != confirmPassword {
            error = "Passwords don't match"
        } else {
            loading = true
            session.signUp(email: email, password: password, name: name) { result in
                self.loading = false
                if case let .failure(err) = result {
                    self.error = err.localizedDescription
                } else {
                    self.success = true
                    self.show = false
                }
            }
        }
    }

    var body: some View {
        VStack {
            Text("Sign up").font(.title).padding(2.0)
            HStack(alignment: .center) {
                Image(systemName: "dollarsign.circle.fill")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .foregroundColor(.blue)
            }
            if success {
                Text("Signup successful!")
            } else {
                Form {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $password)
                    SecureField("Confirm password", text: $confirmPassword)
                    Button(action: handleSignUp) {
                        Text("Sign up")
                    }

                    if error != nil {
                        Text("An error occurred: \(error!)")
                    }
                }
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(show: Binding.constant(true)).environmentObject(SessionStore())
    }
}
