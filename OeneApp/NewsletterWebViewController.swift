//
//  NewsletterWebViewController.swift
//  OeneApp
//
//  Created by Lucas Cerro on 4/28/15.
//  Copyright (c) 2015 Coup. All rights reserved.
//

import UIKit

class NewsletterWebViewController: UIViewController {
    @IBOutlet weak var WebView: UIWebView!
    var urlRequest = NSURLRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        WebView.loadRequest(urlRequest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
