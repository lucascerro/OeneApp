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