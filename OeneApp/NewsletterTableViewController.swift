//
//  NewsletterTableViewController.swift
//  Oene
//
//  Created by Lucas Cerro on 4/27/15.
//  Copyright (c) 2015 Coup. All rights reserved.
//

import UIKit

class NewsletterTableViewController: UITableViewController {
    //MARK: refresh function
    func refreshNewsletters() {
        var endpoint = NSURL(string: "https://www.kimonolabs.com/api/8mghmria?apikey=6xMrJDEUW8UeMXQUSg3bD2ulvwGN8saQ")
        var data = NSData(contentsOfURL: endpoint!)
        if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
                println("json virou dictionary")
                if let results: NSDictionary = json["results"] as? NSDictionary {
                    if let items: NSArray = results["podcasts"] as? NSArray {
                        for item in items {
                            if let foundEntry: NSDictionary = item as? NSDictionary {
                                let newsletterEntry: NewsletterItem = NewsletterItem(json:foundEntry)
                                newsletters.append(newsletterEntry)
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
        }
    }
    

    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 40.0
        refreshNewsletters()
        
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
        cell.targetURL = newsletters[indexPath.row].newsletterURL
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "openNewsletter" {
                if let vc = segue.destinationViewController as? NewsletterWebViewController {
                    let cellInitiator = sender as! NewsletterTableViewCell
                    let urlString = cellInitiator.targetURL
                    let newsletterURLRequest:NSURLRequest = NSURLRequest(URL:urlString)
                    vc.urlRequest = newsletterURLRequest
                }
            }
        }
    
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
