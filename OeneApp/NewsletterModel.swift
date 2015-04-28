//
//  NewsletterModel.swift
//  Oene
//
//  Created by Lucas Cerro on 4/27/15.
//  Copyright (c) 2015 Coup. All rights reserved.
//

import Foundation

class Newsletter: NSObject {
    //Essential Newsletter object data:
    var newsletterTitle = String()
    var newsletterDate = String()
    var newsletterURL = NSURL()
    var newsletterDescription = String()
}

var newsletters = [Newsletter]()