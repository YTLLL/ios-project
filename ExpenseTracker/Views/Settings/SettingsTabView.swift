//
//  SettingsTabView.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/3/21.
//  Copyright © 2021 INFO449. All rights reserved.
//

import SwiftUI
import CoreData

// TODO: Settings tab, link to account system
struct SettingsTabView: View {
    @ObservedObject var setting = Settings()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings")
                    .font(.largeTitle)
                    .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                AccountView()
            }
    
//            Form {
//                Section {
//                    AccountView()
//                }

//                ForEach(Option.options,id: \.id) { settingOption in
//                    OptionRow(option: settingOption)
//                }
//            }
        }
    }
}

struct OptionRow: View {
    let option: Option
    var body: some View {
        Group() {
            if option.isAddSection {
                Section {
                    OptionSettingsView(option: option)
                }
            } else {
                OptionSettingsView(option: option)
            }
        }
    }
}


struct OptionSettingsView : View {
    let option: Option
    
    var body: some View {
        return NavigationLink(destination: OptionInnerDetail(option: option)) {
            HStack {
                Image("default")
                    .resizable()
                    .cornerRadius(12)
                    .frame(width: 25, height: 25)
                    .clipped()
                    .aspectRatio(contentMode: .fit)
                Text(option.title)
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
            }
        }
    }
}




struct OptionInnerDetail: View {
    let option: Option
    var body: some View {
        Form {
            ForEach(option.values,id: \.title) { valuesOption in
                OptionInnerView(value: valuesOption)
            }
        }
        .navigationBarTitle(Text(option.title), displayMode: .inline)
    }
}

struct OptionInnerView: View {
    let value: InnerOptionValues
    var body: some View {
        Group() {
            if value.isAddSection && !value.isUseToggle {
                Section(header: Text(value.headerTitle)) {
                    InnerView(value: value)
                }
            } else if !value.isAddSection && value.isUseToggle {
                ToggleView(value: value)
            } else if value.isAddSection && value.isUseToggle {
                Section(header: Text(value.headerTitle)) {
                    ToggleView(value: value)
                }
            } else {
                InnerView(value: value)
            }
        }
    }
}



struct ToggleView: View {
    let value: InnerOptionValues
    @ObservedObject var toggle = Settings()
    
    var body: some View {
        HStack {
            Image("default")
                .resizable()
                .cornerRadius(12)
                .frame(width: 25, height: 25)
                .clipped()
                .aspectRatio(contentMode: .fit)
            
            Toggle(isOn: $toggle.isToggleOn) {
                Text(value.title)
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
            }
        }
    }
}

struct InnerView: View {
    let value: InnerOptionValues
    
    var body: some View {
        return NavigationLink(destination: EndView(value: value)) {
            HStack {
                Image("default")
                    .resizable()
                    .cornerRadius(12)
                    .frame(width: 25, height: 25)
                    .clipped()
                    .aspectRatio(contentMode: .fit)
                Text(value.title)
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
            }
        }
    }
}



struct EndView: View {
    let value: InnerOptionValues
    
    var body: some View {
        return NavigationLink(destination: EndView(value: value)) {
            
            Text("Coming Soon!!!")
                .font(.system(size: 25))
                .foregroundColor(.blue)
        } .navigationBarTitle(Text(value.title), displayMode: .inline)
    }
}
