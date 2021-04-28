//
//  DetailViewController.swift
//  RedditiOS
//
//  Created by orpan on 27.04.2021.
//

import Foundation
import WebKit

class DetailsViewController : UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    private var webView: WKWebView!
    
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
    
    // MARK: - Private Methods
    
    private func handleNotification(notification:NSNotification) {
           if let url = notification.userInfo?["url"] {
               webView.load(NSURLRequest(url: url as! URL) as URLRequest)
           }
       }
    
    @objc private func openWebView(_ notification: NSNotification) {
        if let linkToOpen = notification.userInfo?["link"] as? String {
            DispatchQueue.main.async {
                guard let url = URL(string: linkToOpen) else {return }
                self.webView.load(URLRequest(url: url))
                self.webView.allowsBackForwardNavigationGestures = true
            }
        }
    }
}

