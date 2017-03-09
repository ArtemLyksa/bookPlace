//
//  Book.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/8/17.
//  Copyright © 2017 Artem Lyksa. All rights reserved.
//

import Foundation
import UIKit

class Book: NSObject {
    var name: String!
    var authors: String!
    var imageURL: URL?
    var image: UIImage?
    var bookDescription: String!
    
    required init(name: String, authors: String, bookDescription: String) {
        self.name = name
        self.authors = authors
        self.bookDescription = bookDescription
    }
}

