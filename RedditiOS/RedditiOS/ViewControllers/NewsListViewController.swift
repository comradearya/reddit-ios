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
    
    internal var newsList : [NewsForView]?
    var refreshControl = UIRefreshControl()
    private var observer: NSObjectProtocol?
    private var pageInc: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        configureView()
        abilityToSaveImage()
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
        
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [unowned self] notification in
            loadData()
        }
        newsTableView.estimatedRowHeight = 70
        newsTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func abilityToSaveImage(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        newsTableView.addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer){
        if sender.state == .began {
            if let indexPath = newsTableView.indexPathForRow(at: sender.location(in: newsTableView)) {
                if let cellObj = newsList?[indexPath.row] {
                    loadImage(for: cellObj).sink {
                        [unowned self] image in
                        self.imageTapped(image!)
                        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                    }
                }
            }
        }
    }
    
    func imageTapped(_ image: UIImage){
            let newImageView = UIImageView(image: image)
            newImageView.frame = UIScreen.main.bounds
            newImageView.backgroundColor = .black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
           // self.view.addSubview(newImageView)
            self.view.addSubview(newImageView)

    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // MARK: - Alerts
    
    private func showErrorAlert(with message: String) {
        let alertController = UIAlertController(title: "Упс",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Повторити ще раз", style: .default) { [weak self] _ in
            self?.loadData()
        }
        let okAction = UIAlertAction(title: "Зрозуміло", style: .cancel)
        alertController.addAction(okAction)
        alertController.addAction(retryAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func loadImage(for postItem: NewsForView) -> AnyPublisher<UIImage?, Never> {
        return Just(postItem.imageUrl)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: postItem.imageUrl)!
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
}

//MARK: - Data Methods

extension NewsListViewController {
    internal func loadData(needToRefresh: Bool = false) {
        NewsRepository.shared.loadData(needToRefresh: needToRefresh){
            [weak self] result in
            switch result{
            case .success(let fetchedNews):
                CoreHelper.savePosts(posts: fetchedNews)
                self?.newsList = fetchedNews
            case .failure(let error):
                self?.showErrorAlert(with: error.localizedDescription)
            }
            self?.newsTableView.tableFooterView = nil
            self?.newsTableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    internal func pushDetailsScene(with postPermalink: String) {
        let url = Configuration.url + postPermalink
        let userInfo = ["link" : url]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: userInfo)
    }
}
