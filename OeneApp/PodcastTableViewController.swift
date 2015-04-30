//
//  PodcastTableViewController.swift
//  Oene
//
//  Created by Lucas Cerro on 4/27/15.
//  Copyright (c) 2015 Coup. All rights reserved.
//

import UIKit

class PodcastTableViewController: UITableViewController, NSXMLParserDelegate {
    //MARK: refresh function
    func refreshPodcasts() {
        let urlString = NSURL(string: "http://www.blubrry.com/feeds/onorte.xml")
        let rssUrlRequest:NSURLRequest = NSURLRequest(URL:urlString!)
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(rssUrlRequest, queue: queue) {
            (response, data, error) -> Void in
            //3
            self.xmlParser = NSXMLParser(data: data)
            self.xmlParser.delegate = self
            self.xmlParser.parse()
        }
    }
    
    
    //MARK: Parse: variables
    var xmlParser: NSXMLParser!
    
    var entryTitle: String!
    var entryDate: String!
    var entryURL: PodcastLinkInfo!
    var entryDuration: String!
    var entrySubtitle: String!
    var entryDescription: String!

    var currentParsedElement = String()
    var weAreInsideAnItem = false
    
    
    //MARK: Parse: funcions
    func parser(parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName: String?,
        attributes attributeDict: [NSObject : AnyObject]){
            if elementName == "item" {
                weAreInsideAnItem = true
            }
            if weAreInsideAnItem {
                switch elementName {
                    case "title":
                        entryTitle = String()
                        currentParsedElement = "title"
    //                case "pubDate":
    //                    entryDate = String()
    //                    currentParsedElement = "pudDate"
    //                case "enclosure":
    //                    entryURL = PodcastLinkInfo()
    //                    currentParsedElement = "enclosure"
    //                case "itunes:duration":
    //                    entryDuration = String()
    //                    currentParsedElement = "itunes:duration"
    //                case "itunes:subtitle":
    //                    entrySubtitle = String()
    //                    currentParsedElement = "itunes:subtitle"
                    case "itunes:summary":
                        entryDescription = String()
                        currentParsedElement = "itunes:summary"
                default: break
            }
            }
    }

    func parser(parser: NSXMLParser,
        foundCharacters string: String?) {
            if weAreInsideAnItem {
                if currentParsedElement == "title" {
                    entryTitle = entryTitle + string!
                }
                if currentParsedElement == "itunes:summary" {
                    entryDescription = entryDescription + string!
                }
            }
    }
    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?) {
            if weAreInsideAnItem {
                if elementName == "title" {
                    currentParsedElement = ""
                }
                if elementName == "itunes:summary" {
                    currentParsedElement = ""
                }
            }
            if elementName == "item" {
                weAreInsideAnItem = false
                var entryPodcast = Podcast()
                entryPodcast.podcastTitle = entryTitle
                entryPodcast.podcastDescription = entryDescription
                podcasts.append(entryPodcast)
            }
    }
    
    func parserDidEndDocument(parser: NSXMLParser){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }


    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60.0
        refreshPodcasts()
        

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
        return podcasts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> PodcastTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PodcastCell", forIndexPath: indexPath) as! PodcastTableViewCell
        
        cell.textLabel!.text = podcasts[indexPath.row].podcastTitle
        cell.detailTextLabel!.text = podcasts[indexPath.row].podcastDescription
            
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
