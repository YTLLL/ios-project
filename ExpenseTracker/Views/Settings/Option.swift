//
//  Option.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/3/21.
//  Copyright © 2021 INFO449. All rights reserved.
//

import SwiftUI
import Combine

struct Option: Codable {
    var id: Int
    var title: String
    var isAddSection: Bool
    var values: [InnerOptionValues]
}

struct InnerOptionValues: Codable {
    var title: String
    var isAddSection: Bool
    var isUseToggle: Bool
    var headerTitle: String
}

extension Option {
    static let generalValues: [InnerOptionValues] = [
        .init(title: "About", isAddSection: true, isUseToggle: false, headerTitle: ""),
        .init(title: "Keyboard", isAddSection: false, isUseToggle: false, headerTitle: ""),
        .init(title: "Fonts", isAddSection: false, isUseToggle: false, headerTitle: ""),
        .init(title: "Language & Region", isAddSection: false, isUseToggle: false, headerTitle: ""),
        .init(title: "Dictionary", isAddSection: false, isUseToggle: false, headerTitle: ""),
        .init(title: "Reset", isAddSection: true, isUseToggle: false, headerTitle: "")
    ]
    
    
    static let options: [Option] = [
        .init(id: 1, title: "General", isAddSection: false, values: generalValues),
    ]
}
