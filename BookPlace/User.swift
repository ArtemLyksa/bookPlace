//
//  User.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/8/17.
//  Copyright © 2017 Artem Lyksa. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String?
    var email: String?
    var accessToken: String?
    
    
    required init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
