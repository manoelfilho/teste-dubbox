//
//  Login.swift
//  Dubbox
//
//  Created by Manoel Filho on 03/07/21.
//

import Foundation

struct Login: Codable {
    let email: String
    let password: String
}

struct DataResponse: Codable {
    let user: User
    let access_token: String
}

struct Response: Codable {
    let success: Bool
    let message: String
    let code: Int
    let data: DataResponse
}

struct User: Codable {
    let name: String
    let email: String
    let identity: String?
    let uuid: String?
    let phone: String?
    let birthday: String?
    let created_at: String?
    let password: String?
}

