//
//  ViewController.swift
//  RedditiOS
//
//  Created by orpan on 24.04.2021.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
        
    //MARK: - Properties
    
    internal let identifier = "newsCell"
    internal var newsList : [NewsForView]?
    var refreshControl = UIRefreshControl()
    private var observer: NSObjectProtocol?
    private var pageInc: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Оновлюємо")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        newsTableView.addSubview(refreshControl)
        
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [unowned self] notification in
            loadData()
        }
        newsTableView.estimatedRowHeight = 70
        newsTableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UI

extension NewsListViewController {
    
    @objc func refresh(_ sender: AnyObject) {
        loadData(needToRefresh: true)
        refreshControl.endRefreshing()
        self.newsTableView.reloadData()
    }
    
    // MARK: - Alerts
    
    private func showErrorAlert(with message: String) {
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.loadData()
        }
        alertController.addAction(retryAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}

//MARK: - Data Methods
extension NewsListViewController {
    internal func loadData(needToRefresh: Bool = false) {
        NewsRepository.shared.loadData(needToRefresh: needToRefresh){
            [weak self] result in
            switch result{
            case .success(let fetchedNews):
                self?.newsList = fetchedNews
            case .failure(let error):
                self?.showErrorAlert(with: error.localizedDescription)
            }
            DispatchQueue.main.async {
                self?.newsTableView.tableFooterView = nil
                self?.newsTableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    internal func pushDetailsScene(with postPermalink: String) {
        let url = Configuration.url + postPermalink
            let userInfo = ["link" : url]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: userInfo)
    }
}
