//
//  BookTableViewCell.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/8/17.
//  Copyright © 2017 Artem Lyksa. All rights reserved.
//

import Foundation
import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
    }
}
