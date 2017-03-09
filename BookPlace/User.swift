//
//  User.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/8/17.
//  Copyright © 2017 Artem Lyksa. All rights reserved.
//

import Foundation

class User {
    var name: String!
    var email: String!
    var books: [Book] = []
    var accessToken: String?
    
    static let sharedInstance = User()
    private init() {}
}
