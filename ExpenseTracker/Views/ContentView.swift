//
//  BreakdownCategoryView.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/3/21.
//  Copyright © 2021 INFO449. All rights reserved.
//

import SwiftUI
import Firebase

// App content with different tabs and views
struct ContentView: View {
    @EnvironmentObject var session: SessionStore

    func getUser () {
      session.listen()
    }

    
    var body: some View {
        Group {
            if (session.loggedIn) {
                
                TabView {
                    DashboardTabView()
                        .tabItem {
                            VStack {
                                Text("Home").foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                                Image(systemName: "house.fill").renderingMode(.template)
                            }
                    }
                    .tag(0)
                    
                    LogsTabView()
                        .tabItem {
                            VStack {
                                Text("Transactions").foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                                Image(systemName: "text.badge.plus").renderingMode(.template)
                            }
                    }
                    .tag(1)
                    
                    SettingsTabView()
                        .tabItem {
                            VStack {
                                Text("Settings").foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                                Image(systemName: "gear").renderingMode(.template)
                            }
                        }
                    .tag(2)

                }.accentColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
            } else {
                //AuthenticationScreen()
            }
        }.onAppear(perform: getUser)
    }

    
//    init() {
//        UISegmentedControl.appearance().selectedSegmentTintColor = hexStringToUIColor(hex:"#cf99f0")
//        //UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemYellow], for: .normal)
//        //UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
//
//    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStore())
    }
}
