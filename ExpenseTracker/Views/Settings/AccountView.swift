//
//  AccountView.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/3/21.
//  Copyright © 2021 INFO449. All rights reserved.
//

import SwiftUI

struct AccountView : View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: AccountSettingsView()) {
                HStack(alignment: .top) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .cornerRadius(20)
                        .frame(width: 60, height: 60)
                        .clipped()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                }
                
                VStack(alignment: .leading) {
                    Text("Add Account")
                        .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                        .font(.system(size: 18))
                        .lineLimit(nil)
                    Text("Add an account to save expenses.")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                        .lineLimit(nil)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct AccountSettingsView : View {
    @State var loading = false
    @State var error = false
    @EnvironmentObject var session: SessionStore

    func signOut () {
        loading = true
        error = false
        session.signOut()
    }
    
    var body: some View {
        HStack {
            NavigationLink(destination: ContentView()) {
                CustomButton(
                    label: "Sign Out",
                    action: signOut,
                    loading: loading
                    )
                    .padding()
            }
            
        }
    }
}
