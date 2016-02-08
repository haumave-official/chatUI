//
//  Author.swift
//  ChatUI
//
//  Created by Max Suvorov on 07.02.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import Foundation

struct Author {
    var title: String
    var imageName: String
    
    init(_title: String, _imageName: String) {
        self.title = _title
        self.imageName = _imageName
    }
}