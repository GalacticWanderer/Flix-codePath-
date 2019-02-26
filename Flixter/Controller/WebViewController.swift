//
//  WebViewController.swift
//  Flixter
//
//  Created by Joy Paul on 2/25/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate{

    //var webView: WKWebView!
    
    var url: URL!
    
    //outlet for the WKView
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //passing an URL request and then loading the request
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
}
