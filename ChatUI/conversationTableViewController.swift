//
//  conversationTableViewController.swift
//  ChatUI
//
//  Created by Max Suvorov on 07.02.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import UIKit

class conversationTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "conversationMessage", bundle: nil), forCellReuseIdentifier: "messageCell_right")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentManager.sharedInstance.messagesInConversation
    }
    
    /*override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let metricLabel = UILabel()
        metricLabel.text = messagesForConversation[indexPath.row].text
        metricLabel.numberOfLines = 0
        metricLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        metricLabel.frame = CGRectMake( 0, 0, 200, CGFloat(MAXFLOAT) )
        metricLabel.sizeToFit()

        return metricLabel.frame.size.height+70
    }*/

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var messageCellNibName = "conversationMessage_right"
        var messageCellReuseIdentifier = "messageCell_right"
        
        if ( indexPath.row.isEven() ) {
            messageCellNibName = "conversationMessage_left"
            messageCellReuseIdentifier = "messageCell_left"
        }
        
        var cell:messageTableViewCell! = tableView.dequeueReusableCellWithIdentifier(messageCellReuseIdentifier) as? messageTableViewCell
        
        if (cell == nil) {
            tableView.registerNib(UINib(nibName: messageCellNibName, bundle: nil), forCellReuseIdentifier: messageCellReuseIdentifier)
            cell = tableView.dequeueReusableCellWithIdentifier(messageCellReuseIdentifier) as? messageTableViewCell
        }
        
        cell.senderImage.layer.cornerRadius = 5
        cell.senderImage.clipsToBounds = true
        
        cell.textBlock.layer.cornerRadius = 4.5
        cell.textBlock.clipsToBounds = true
        
        let messageItem = messagesForConversation[indexPath.row]
        
        cell.senderImage.image = UIImage(named: messageItem.author.imageName)
        cell.senderTitle.text = messageItem.author.title.uppercaseString
        cell.messageText.text = messageItem.text
        

        
        return cell
    }
    
    func createDateLabel (dateString: String) -> String {
        return "Today at" + dateString
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
        
            let numberOfRows = contentManager.sharedInstance.messagesInConversation
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: 0)
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
