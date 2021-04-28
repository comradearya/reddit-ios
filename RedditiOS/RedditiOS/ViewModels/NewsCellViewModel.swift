//
//  NewsCellViewModel.swift
//  RedditiOS
//
//  Created by orpan on 24.04.2021.
//

import UIKit
import CoreData

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
        DispatchQueue.main.async {
            self.cellTitleLabel.text = item.title
            self.cellDescriptionLabel.text = item.newsDescription
            self.cellAuthorLabel.text = "Автор \(item.author)"
            self.cellCreatedLabel.text = item.created.timeAgoDisplay()
            self.cellCommentsLabel.text = "Коментарі: \(String(item.numberOfComments))"
       
            ImageController.shared.downloadImage(
                with: item.imageUrl,
                completionHandler :{
                    (image, cached) in
                    self.postImageView.image = image },
                placeholderImage: UIImage(
                    named: "placeholder_profile_pic"))
        }
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
            return "\(secondsAgo) сек"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) хв"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) год"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) дн"
        }
        return "\(secondsAgo / week) тижд"
    }
}

