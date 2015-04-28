//
//  NewsletterTableViewController.swift
//  Oene
//
//  Created by Lucas Cerro on 4/27/15.
//  Copyright (c) 2015 Coup. All rights reserved.
//

import UIKit

class NewsletterTableViewController: UITableViewController, NSXMLParserDelegate {
    //MARK: refresh function
    func refreshNewsletters() {
        let urlString = NSURL(string: "http://tinyletter.com/Oene/archive")
        let rssUrlRequest:NSURLRequest = NSURLRequest(URL:urlString!)
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(rssUrlRequest, queue: queue) {
            (response, data, error) -> Void in
            self.xmlParser = NSXMLParser(data: data)
            self.xmlParser.delegate = self
            println("vai chamar o parse!")
            self.xmlParser.parse()
        }
    }
    
    //MARK: Parse: variables
    var xmlParser: NSXMLParser!
    
    var entryTitle: String!
    var entryDate: String!
    var entryURL: NSURL!
    var entryDescription: String!
    
    var currentNewsletterParsedElement = String()
    var weAreInsideAnLI = false
    var weAreInsideAnAnchor = false
    
    //MARK: Parse: functions
    func parser(parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName: String?,
        attributes attributeDict: [NSObject : AnyObject]){
            if elementName == "li" {
                weAreInsideAnLI = true
                println("we're inside an <li>")
            }
            if weAreInsideAnLI {
                if elementName == "a" {
                    entryURL = attributeDict["href"] as! NSURL
                    weAreInsideAnAnchor = true
                }
                switch elementName {
                case "span":
                    if weAreInsideAnAnchor {
                        entryTitle = String()
                        currentNewsletterParsedElement = "title"
                    } else {
                        entryDate = String()
                        currentNewsletterParsedElement = "date"
                    }
                case "p":
                    entryDescription = String()
                    currentNewsletterParsedElement = "description"
                default: break
                }
            }
    }
    
    func parser(parser: NSXMLParser,
        foundCharacters string: String?) {
            if weAreInsideAnLI {
                switch currentNewsletterParsedElement {
                    case "title":
                    entryTitle = entryTitle + string!
                    case "date":
                    entryDate = entryDate + string!
                    case "description":
                    entryDescription = entryDescription + string!
                default: break
                }
            }
    }

    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?) {
            if weAreInsideAnLI {
                switch elementName {
                    case "title":
                    currentNewsletterParsedElement = ""
                    case "date":
                    currentNewsletterParsedElement = ""
                    case "description":
                    currentNewsletterParsedElement = ""
                    case "a":
                    weAreInsideAnAnchor = false
                    case "li":
                    var entryNewsletter = Newsletter()
                    entryNewsletter.newsletterTitle = entryTitle
                    entryNewsletter.newsletterDescription = entryDescription
                    entryNewsletter.newsletterDate = entryDate
                    entryNewsletter.newsletterURL = entryURL
                    newsletters.append(entryNewsletter)
                    weAreInsideAnLI = false
                default: break
                }
            }
    }
    
    func parserDidEndDocument(parser: NSXMLParser){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            println(newsletters.count)
            println("title 0 = \(newsletters[0].newsletterTitle)")
            println("description 0 = \(newsletters[0].newsletterDescription)")
            println("title 5 = \(newsletters[5].newsletterTitle)")
            println("description 5 = \(newsletters[5].newsletterDescription)")
            self.tableView.reloadData()
        })
    }


    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 40.0
        refreshNewsletters()
        
        // self.titlesTableView.estimatedRowHeight = 40.0

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return newsletters.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> NewsletterTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsletterCell", forIndexPath: indexPath) as! NewsletterTableViewCell

        cell.textLabel!.text = newsletters[indexPath.row].newsletterTitle
        cell.detailTextLabel!.text = newsletters[indexPath.row].newsletterDescription
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
