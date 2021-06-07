//
//  User.swift
//  ExpenseTracker
//
//  Created by Melody Chou on 6/7/21.
//  Copyright © 2021 INFO449. All rights reserved.
//
import Foundation
import SwiftUI

struct User {
    var uid: String
    var email: String?
    var photoURL: URL?
    var displayName: String?
    
    static let `default` = Self(
        uid: "test",
        displayName: "Lorem Ipsum",
        email: "test.test@test.com",
        photoURL: nil
    )

    init(uid: String, displayName: String?, email: String?, photoURL: URL?) {
        self.uid = uid
        self.email = email
        self.photoURL = photoURL
        self.displayName = displayName
    }
}
