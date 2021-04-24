//
//  ViewController.swift
//  RedditiOS
//
//  Created by orpan on 24.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    //MARK: - Properties
    
    let identifier = "newsCell"
    var newsList = [NewsForView] ()
    var refreshControl = UIRefreshControl()
    private var observer: NSObjectProtocol?
    
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    @objc func refresh(_ sender: AnyObject) {
        loadData()
        refreshControl.endRefreshing()
        self.newsTableView.reloadData()
    }
    private func loadData() {
        let anonymousFunction = { (fetchedNewsList: [NewsForView]) in
            if fetchedNewsList.isEmpty {
                //   self.newsList = lastNewsForViewList
                // self.newsTableView.reloadData()
            }
            else {
                self.newsList.append(contentsOf: fetchedNewsList)
            }
            self.newsTableView.reloadData()
        }
        NewsRepository.shared.fetchNewsList(onCompletion: anonymousFunction)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? NewsCellViewModel {
            cell.configureCell(item: newsList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         if let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewControllerIdentifier") as? DetailViewController {
         self.present(detailsViewController, animated: true, completion: nil)
         detailsViewController.titleLabel.text = newsList[indexPath.row].title
         detailsViewController.descriptionLabel.text = newsList[indexPath.row].newsDescription
         detailsViewController.configure(with: newsList[indexPath.row])
         }*/
    }
}

