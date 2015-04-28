//
//  NewsletterModel.swift
//  Oene
//
//  Created by Lucas Cerro on 4/27/15.
//  Copyright (c) 2015 Coup. All rights reserved.
//

import Foundation

class NewsletterItem: NSObject {
    //Essential Newsletter object data:
    var newsletterTitle = String()
    var newsletterDate = String()
    var newsletterURL = NSURL()
    var newsletterDescription = String()
    
    init(json: NSDictionary) {
        if let titleAndLink: NSDictionary = json["title"] as? NSDictionary {
            self.newsletterTitle = titleAndLink["text"] as! String
            println("new Title = \(self.newsletterTitle)")
            println(titleAndLink["href"]!)
//            let url: String = titleAndLink["href"] as! String
            self.newsletterURL = NSURL(string: (titleAndLink["href"]! as! String))!
            println("new URL = \(self.newsletterURL)")
        }
        self.newsletterDescription = json["description"] as! String
        println("new Description = \(self.newsletterDescription)")
        self.newsletterDate = json["pubDate"] as! String
        println("new Date = \(self.newsletterDate)")
    }
}

var newsletters = [NewsletterItem]()