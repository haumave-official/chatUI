//
//  message.swift
//  ChatUI
//
//  Created by Max Suvorov on 07.02.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import UIKit

struct Message {
    var messageID: Int
    var author: Author
    var text: String
    var date: String
    
    init (_messageID: Int, _author: Author, _text: String, _date: String) {
        self.messageID = _messageID
        self.author = _author
        self.text = _text
        self.date = _date
    }
}
