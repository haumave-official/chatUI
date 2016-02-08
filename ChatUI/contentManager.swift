//
//  contenManager.swift
//  ChatUI
//
//  Created by Max Suvorov on 07.02.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import UIKit

var messagesForConversation: [Message] = []

class contentManager: NSObject {
    
    static let sharedInstance = contentManager()
    
    var messagesInConversation = 20
    
    let authorsList: NSArray = [
        "Jordan Belfort",
        "Warren Buffett",
        "John Ive",
        "Maksym Suvorov",
        "Alexander Wang",
        "Gosha Rubchinskiy",
        "Dale Carnegie",
        "Leonardo Dicaprio",
        "Robert Downey Jr.",
        "Mikhail Freedman",
        "Kanye West",
        "Mark Zuckerberg",
        "Elon Musk",
        "Oleg Tinkov",
        "Rick Ross",
        "Puff Daddy",
        "Donald Trump",
        "Carlos Slim",
        "Charles Koch",
        "Amancio Ortega",
        "Come De Garcons",
        "Alisa Babenko",
    ]
    
    let imageNamesList: NSArray = [
        "profileIcon_1",
        "profileIcon_2",
        "profileIcon_3"
    ]
    
    let exampleMessagesList: NSArray = [
        "Let's head over to the Rainbow...",
        "The slience is golden.",
        "I'm foolish and hungry.",
        "I'm breaking a sweat.",
        "I'm a god.",
        "See you tomorrow."
    ]
    
    var authorsArray: [Author] = []
    
    override init() {
        super.init()
        createAuthors()
        createMessagesInConversation(0)
    }
    
    private func createAuthors () {
        for var i = 0; i <= messagesInConversation; ++i {
            let authorTitle: String = authorsList[i] as! String
            
            let randomIndexForImage = Int( arc4random_uniform(3) )
            let authorImageName: String = imageNamesList[randomIndexForImage] as! String
            
            let authorItem = Author(_title: authorTitle, _imageName: authorImageName)
            authorsArray.insert(authorItem, atIndex: i)
        }
    }
    
    private func createMessagesInConversation (conversationID: Int) {
        for var i = 0; i <= messagesInConversation-1; ++i {
            let randomIndexForMessage = Int( arc4random_uniform(5) )
            let messageItem = Message(_messageID: i, _author: authorsArray[i], _text: exampleMessagesList[randomIndexForMessage] as! String, _date: "4:43 PM")
            
            messagesForConversation.insert(messageItem, atIndex: i)
        }
    }
    
    func addMessageWithRandomAuthor (messageText: String) {
        messagesInConversation++
        
        let randomIndexForAuthor = Int( arc4random_uniform(20) )
        let randomAuthor = authorsArray[randomIndexForAuthor]
        
        let newMessage = Message(_messageID: messagesInConversation, _author: randomAuthor, _text: messageText, _date: "the date")
        
        messagesForConversation.insert(newMessage, atIndex: messagesInConversation-1)
        
        NSNotificationCenter.defaultCenter().postNotificationName("messageSent", object: nil)
    }

}


