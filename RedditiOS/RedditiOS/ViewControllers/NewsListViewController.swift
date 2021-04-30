//
//  ViewController.swift
//  RedditiOS
//
//  Created by orpan on 24.04.2021.
//

import UIKit
import CoreData
import Combine

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    //MARK: - Properties
    
    internal var newsList = [NewsForView]()
    var refreshControl = UIRefreshControl()
    private var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        configureView()
        self.newsTableView.reloadData()
    }
}

// MARK: - UI

extension NewsListViewController {
    
    @objc func refresh(_ sender: AnyObject) {
        loadData(needToRefresh: true)
        refreshControl.endRefreshing()
        self.newsTableView.reloadData()
    }
    
    private func configureView(){
        refreshControl.attributedTitle = NSAttributedString(string: "Оновлюємо")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        newsTableView.addSubview(refreshControl)
        
        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil, queue: nil) { [unowned self] notification in
            loadData()
        }
        
        let longPress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(handleLongPress(sender:)))
        newsTableView.addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer){
        if sender.state == .began {
            guard let indexPath = newsTableView.indexPathForRow(at: sender.location(in: newsTableView)) else { return }
            self.addImageSubview(newsList[indexPath.row].imageUrl)
        }
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
                CoreHelper.savePosts(posts: fetchedNews)
            case .failure:
                self?.newsList = CoreHelper.fetchPosts()
                self?.showAlert(.noInternet) {
                    self?.loadData()
                }
            }
            self?.newsTableView.tableFooterView = nil
            self?.newsTableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    internal func pushDetailsScene(with postPermalink: String) {
        let url = NetworkConfiguration.hostUrl + postPermalink
        let userInfo = ["link" : url]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: userInfo)
    }
}
