//
//  PodcastModel.swift
//  Oene
//
//  Created by Lucas Cerro on 4/27/15.
//  Copyright (c) 2015 Coup. All rights reserved.
//

import Foundation

class PodcastLinkInfo {
    var podcastURL = NSURL()
    var podcastLength = Int()
    var podcastDataType = String()
}

//class Parser: NSObject, NSXMLParserDelegate {
    //Constants
//    static let urlString: NSURL = NSURL(string: "http://www.blubrry.com/feeds/onorte.xml")!
//    static let rssUrlRequest:NSURLRequest = NSURLRequest(URL:urlString)
//    static let queue:NSOperationQueue = NSOperationQueue()
    
    
    //vars for the parse functions
//    static var xmlParser: NSXMLParser!
//    var entryTitle: String!
//    var entryDate: String!
//    var entryURL: PodcastLinkInfo!
//    var entryDuration: String!
//    var entrySubtitle: String!
//    var entryDescription: String!



//    var currentParsedElement:String! = String()
//
//    
//    Fetch Podcasts
//    class func fetchPodcasts() {
//        NSURLConnection.sendAsynchronousRequest(self.rssUrlRequest, queue: queue) {  //Async Request has to refresh Table?
//            (response, data, error) -> Void in
//            self.xmlParser = NSXMLParser(data: data)
//            self.xmlParser.delegate = self
//            self.xmlParser.parse()
//        }
        //REFRESH DATABASE?
        //REFRESH TABLE (reloadData)?
//    }
//    
//    
//    parser
//    func parser(parser: NSXMLParser,
//        didStartElement elementName: String,
//        namespaceURI: String?,
//        qualifiedName: String?,
//        attributes attributeDict: [NSObject : AnyObject]){
//            println("começou didStartElement!")
//            switch elementName {
//                case "title":
//                    entryTitle = String()
//                    currentParsedElement = "title"
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
//                case "summary":
//                    entryDescription = String()
//                    currentParsedElement = "summary"
//            default: break
//            }
//            if elementName == "title"{
//                entryTitle = String()
//                currentParsedElement = "title"
//            }
//            if elementName == "description"{
//                entryDescription = String()
//                currentParsedElement = "description"
//            }
//            if elementName == "link"{
//                entryLink = String()
//                currentParsedElement = "link"
//            }
//    }
//
//    func parser(parser: NSXMLParser,
//        foundCharacters string: String?){
//            if currentParsedElement == "title" {
//                entryTitle = entryTitle + string!
//            }
//            if currentParsedElement == "summary" {
//                entryDescription = entryDescription + string!
//            }
//    }
//    //3
//    func parser(parser: NSXMLParser,
//        didEndElement elementName: String,
//        namespaceURI: String?,
//        qualifiedName qName: String?){
//            var entryPodcast = Podcast()
//            if elementName == "title"{
//                entryPodcast.podcastTitle = entryTitle!
//            }
//            if elementName == "description"{
//                entryPodcast.podcastDescription = entryDescription
//                podcasts.append(entryPodcast)
//            }
//    }
//    //4
//    func parserDidEndDocument(parser: NSXMLParser){
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            println(podcasts.count)
//            // self.titlesTableView.reloadData() ======> RELOAD TABLE HERE!
//        })
//    }
//}





class Podcast: NSObject {
    //Essential Podcast object data:
    var podcastTitle = String()
    var podcastDate = String()
    var podcastLinkInfo = PodcastLinkInfo()
    var podcastDuration = String()
    var podcastSubtitle = String()
    var podcastDescription = String()

    var podcastAudio = NSData()
}

var podcasts = [Podcast]()
var podcastsRef: [Podcast] {
    get {
        return podcasts
    }
    set {
        podcasts = newValue
        //refresh? Think not. Better in Controller.
    }
}

//func fetchPodcasts () -> [Podcast] {
//    let url = NSURL(string: "http://www.blubrry.com/feeds/onorte.xml")
//    let session = NSURLSession.sharedSession()
//    let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
//        println("Task completed")
//        if(error != nil) {
//            // If there is an error in the web request, print it to the console
//            println(error.localizedDescription)
//        }
//        var err: NSError?
//        if let xmlResult = NSXMLParser
//        if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
//            if(err != nil) {
//                // If there is an error parsing JSON, print it to the console
//                println("JSON Error \(err!.localizedDescription)")
//            }
//            if let results: NSArray = jsonResult["results"] as? NSArray {
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.tableData = results
//                    self.appsTableView!.reloadData()
//                })
//            }
//        }
//    })
//
//}



//let url = NSURL(string: urlPath)
//let session = NSURLSession.sharedSession()
//let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
//    println("Task completed")
//    if(error != nil) {
//        // If there is an error in the web request, print it to the console
//        println(error.localizedDescription)
//    }
//    var err: NSError?
//    if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
//        if(err != nil) {
//            // If there is an error parsing JSON, print it to the console
//            println("JSON Error \(err!.localizedDescription)")
//        }
//        if let results: NSArray = jsonResult["results"] as? NSArray {
//            dispatch_async(dispatch_get_main_queue(), {
//                self.tableData = results
//                self.appsTableView!.reloadData()
//            })
//        }
//    }
//})
