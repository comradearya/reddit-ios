//
//  DetailsViewController+Extension.swift
//  RedditiOS
//
//  Created by orpan on 28.04.2021.
//

import WebKit

extension DetailsViewController {
    
    // MARK: - Private Methods
    
    @objc internal func openWebView(_ notification: NSNotification) {
        if let linkToOpen = notification.userInfo?["link"] as? String {
            DispatchQueue.main.async {
                guard let url = URL(string: linkToOpen) else {return }
                self.webView.load(URLRequest(url: url))
                self.webView.allowsBackForwardNavigationGestures = true
            }
        }
    }
}

