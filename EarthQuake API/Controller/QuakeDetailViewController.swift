//
//  QuakeDetailViewController.swift
//  EarthQuake API
//
//  Created by anhxa100 on 11/16/18.
//  Copyright © 2018 anhxa100. All rights reserved.
//

import UIKit
import WebKit

class QuakeDetailViewController: UIViewController, WKUIDelegate {


    var myURLRequest = ""
    var detailAPI = ""
    var webview: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webview = WKWebView(frame: .zero, configuration: webConfiguration)
        webview.uiDelegate = self
        view = webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let myURL = URL(string: myURLRequest) {
            let myRequest = URLRequest(url: myURL)
            webview.load(myRequest)
            print(detailAPI)
        }
    }
    
    @IBAction func gotoDetail(_ sender: Any) {
        
    }
    
  

}
