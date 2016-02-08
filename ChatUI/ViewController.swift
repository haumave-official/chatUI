//
//  ViewController.swift
//  ChatUI
//
//  Created by Max Suvorov on 07.02.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import UIKit

enum validationResult {
    case noSymbols
    case tooManySymbols
    case Ok
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var segmentedTopBar: UISegmentedControl!
    @IBOutlet weak var conversationTableView: UITableView!
    @IBOutlet weak var messageFormView: UIView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var sendingItemsView: UIView!
    
    @IBOutlet weak var commentFormBottomSpacing: NSLayoutConstraint!
    
    let conversationVC = conversationTableViewController()
    
    var sendingItemsViewIsVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGUI()
        self.setupNotifications()
        
        self.conversationTableView.reloadData()
        self.conversationTableView.scrollToBottom()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func setupGUI () {
        setupSegmentedTopBar()
        
        self.conversationTableView.delegate = conversationVC
        self.conversationTableView.dataSource = conversationVC
        self.conversationVC.tableView = self.conversationTableView
        
        self.messageTextfield.borderStyle = UITextBorderStyle.Line
        self.messageTextfield.layer.borderColor = UIColor.grayColor().CGColor
        self.messageTextfield.layer.borderWidth = 2
        self.messageTextfield.layer.cornerRadius = 4
        self.messageTextfield.clipsToBounds = true
        self.messageTextfield.backgroundColor = UIColor.whiteColor()
    }
    
    func setupNotifications () {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillChange:",
            name: UIKeyboardWillChangeFrameNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillHide",
            name: UIKeyboardWillHideNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "messageSent",
            name: "messageSent",
            object: nil)
    }
    
    func setupSegmentedTopBar () {
        self.segmentedTopBar.removeBorders()
        self.segmentedTopBar.setCornerRadius(2.5)
        
        if let segmentedTopBarFont: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 10) {
            let segmentedTopBarTitleAttr: NSDictionary = [NSFontAttributeName: segmentedTopBarFont]
            self.segmentedTopBar.setTitleTextAttributes(segmentedTopBarTitleAttr as [NSObject : AnyObject], forState: .Normal)
        }
    }
    
    @IBAction func triggerSendingItemsView () {
        if ( !self.sendingItemsViewIsVisible ) {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.sendingItemsView.alpha = 1
                self.sendingItemsView.center = CGPointMake(self.sendingItemsView.center.x, self.sendingItemsView.center.y + 30)
                self.sendingItemsViewIsVisible = true
            })
        }
        else {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.sendingItemsView.alpha = 0
                self.sendingItemsView.center = CGPointMake(self.sendingItemsView.center.x, self.sendingItemsView.center.y - 30)
                self.sendingItemsViewIsVisible = false
            })
        }
    }
    
    func sendMessage () -> Bool {
        let messageText = self.messageTextfield.text
        
        if ( validateMessage(messageText!) == .Ok ) {
            
            contentManager.sharedInstance.addMessageWithRandomAuthor(messageText!)
            return true
        }
        else {
            return false
        }
    }
    
    func validateMessage (text: String) -> validationResult {
        if ( text.characters.count == 0 ) {
            return validationResult.noSymbols
        }
        else if ( text.characters.count > 300 ) {
            return validationResult.tooManySymbols
        }
        
        return validationResult.Ok
    }
    
    func messageSent () {
        self.conversationVC.tableViewScrollToBottom(true)
        self.conversationTableView.reloadData()
    }
    
    func keyboardWillHide () {
        self.commentFormBottomSpacing.constant = 0
       
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillChange (notification: NSNotification) {
        self.conversationVC.tableViewScrollToBottom(true)
        
        let keyboardInfo = notification.userInfo
        let keyboardFrame: CGRect = ( keyboardInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue ).CGRectValue()
        
        self.commentFormBottomSpacing.constant = keyboardFrame.size.height
        
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if ( self.sendMessage() ) {
            self.messageTextfield.text = "" // Clear if message sent.
        }
        
        return true
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

