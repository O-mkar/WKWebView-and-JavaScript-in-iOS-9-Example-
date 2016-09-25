//
//  ViewController.swift
//  WebViewCallBack
//
//  Created by O-mkar on 20/09/16.
//  Copyright © 2016 O-mkar. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    
    var webView: WKWebView?
    
    override func loadView() {
        super.loadView()
        
        let contentController = WKUserContentController()
        let userScript = WKUserScript(
            source: "setText(\"Hi JavaScript\")",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        contentController.addScriptMessageHandler(
            self,
            name: "callback"
        )
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(
            frame: self.view.bounds,
            configuration: config
        )
        self.view = self.webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string:"https://rawgit.com/O-mkar/WKWebView-and-JavaScript-in-iOS-9-Example-/master/WEBPART/index.html")
        let req = NSURLRequest(URL:url!)
        self.webView!.loadRequest(req)
        
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "callback") {
//            print("\(message.body)")
            let alert = UIAlertController(title: "Message", message: "Message from JavaScript: \(message.body)", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}