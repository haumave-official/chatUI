//
//  messageTableViewCell.swift
//  ChatUI
//
//  Created by Max Suvorov on 07.02.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import UIKit

class messageTableViewCell: UITableViewCell {
    @IBOutlet weak var senderImage: UIImageView!
    @IBOutlet weak var textBlock: UIView!
    @IBOutlet weak var senderTitle: UILabel!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var messageDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
