//
//  ConnectedView.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/5/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct ConnectedView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            TransactionListView()
                .tabItem {
                    VStack {
                        Image(systemName: "dollarsign.circle")
                        Text("Transactions")
                    }
                }
                .tag(0)

            AccountView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.crop.circle")
                        Text("Account")
                    }
                }
                .tag(1)
        }
    }
}

struct ConnectedView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectedView()
    }
}
