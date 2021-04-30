//
//  NewsListViewController+Delegate.swift
//  RedditiOS
//
//  Created by orpan on 26.04.2021.
//

import UIKit

extension NewsListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.height
        if bottomEdge >= scrollView.contentSize.height {
            loadData()
        }
    }
}
 
//MARK: - Extension for TableView

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Configuration.newsCellIdentifier, for: indexPath) as? NewsCellViewModel {
            cell.configureCell(item: newsList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushDetailsScene(with:  newsList[indexPath.row] .postUrl)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
