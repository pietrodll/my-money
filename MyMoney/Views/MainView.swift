//
//  MainView.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/6/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: SessionStore
    
    func initAuth() {
        session.listen()
    }

    var body: some View {
        Group {
            if session.session != nil {
                ConnectedView()
            } else {
                LoginView()
            }
        }.onAppear(perform: initAuth)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(SessionStore())
    }
}
