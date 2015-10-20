//
//  BookTableViewCell.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/17/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
//cell ccontroller to wire up the cell ui elements to the table view controller
    @IBOutlet weak var bookImageOnCell: UIImageView!
    @IBOutlet weak var bookTitleOnCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
