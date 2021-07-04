//
//  UserData.swift
//  Dubbox
//
//  Created by Manoel Filho on 04/07/21.
//

import Foundation
class UserData: ObservableObject {
    @Published() var loggedIn = (UserDefaults.standard.object(forKey: "auth") != nil) ? true : false
}
