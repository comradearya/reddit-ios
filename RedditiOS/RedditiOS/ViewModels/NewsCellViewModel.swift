//
//  NewsCellViewModel.swift
//  RedditiOS
//
//  Created by orpan on 24.04.2021.
//

import Foundation
import UIKit

class NewsCellViewModel: UITableViewCell{
    
    //MARK: - Outlets
    
    @IBOutlet var cellAuthorLabel: UILabel!
    @IBOutlet var cellTitleLabel: UILabel!
    @IBOutlet var cellDescriptionLabel: UILabel!
    @IBOutlet var cellCreatedLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet var cellCommentsLabel: UILabel!
    
    //MARK: - Public Methods
    
    func configureCell(item: NewsForView){
        cellTitleLabel.text = item.title
        cellDescriptionLabel.text = item.newsDescription
        cellAuthorLabel.text = "Author \(item.author)"
        cellCreatedLabel.text = item.created.timeAgoDisplay()
        cellCommentsLabel.text = "Comments: \(String(item.numberOfComments))"
    
        ImageController.shared.downloadImage(
            with: item.imageUrl,
            completionHandler :{
                (image, cached) in
                self.postImageView.image = image },
            placeholderImage: UIImage(
                named: "placeholder_profile_pic"))
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "posted \(secondsAgo) sec ago"
        } else if secondsAgo < hour {
            return "posted \(secondsAgo / minute) min ago"
        } else if secondsAgo < day {
            return "posted \(secondsAgo / hour) hrs ago"
        } else if secondsAgo < week {
            return "posted \(secondsAgo / day) days ago"
        }
        
        return "posted \(secondsAgo / week) weeks ago"
    }
}

