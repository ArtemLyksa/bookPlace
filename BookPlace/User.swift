//
//  User.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/8/17.
//  Copyright © 2017 Artem Lyksa. All rights reserved.
//

import Foundation
import UIKit

class User {
    var name: String!
    var email: String!
    var books: [Book] = []
    var imageURL: URL?
    var image: UIImage?
    
    private static var privateShared : User?
    
    class func sharedInstance() -> User { // change class to final to prevent override
        guard let uwShared = privateShared else {
            privateShared = User()
            return privateShared!
        }
        return uwShared
    }
    
    class func destroy() {
        privateShared = nil
    }
    
    private init() {
        print("init singleton")
    }
    
    deinit {
        print("deinit singleton")
    }
}
