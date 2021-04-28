//
//  DetailViewController.swift
//  RedditiOS
//
//  Created by orpan on 27.04.2021.
//

import Foundation
import WebKit

class DetailsViewController : UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    internal var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.openWebView(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
    }
}
