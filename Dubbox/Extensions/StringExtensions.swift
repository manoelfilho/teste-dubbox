//
//  StringExtensions.swift
//  Dubbox
//
//  Created by Manoel Filho on 03/07/21.
//

import Foundation

extension String {

  var isValidEmail: Bool {
    let name = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
    let domain = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
    let emailRegEx = name + "@" + domain + "[A-Za-z]{2,8}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailPredicate.evaluate(with: self)
  }

}
