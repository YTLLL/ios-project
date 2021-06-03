//
//  Settings.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/3/21.
//  Copyright © 2021 INFO449. All rights reserved.
//

import SwiftUI
import Combine

class Settings: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    @Published var isBluetoothOn = false { didSet { update() } }
    
    @Published var types = ["Off","On"]
    @Published var type = 0 { didSet { update() } }
    
    @Published var isToggleOn = false { didSet { update() } }
    
    func update() {
        didChange.send(())
    }
}
