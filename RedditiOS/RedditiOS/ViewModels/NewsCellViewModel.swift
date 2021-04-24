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
    @IBOutlet var cellCommentsLabel: UILabel!
    
    //MARK: - Public Methods

    func configureCell(item: NewsForView){
        cellTitleLabel.text = item.title
        cellDescriptionLabel.text = item.newsDescription
        cellAuthorLabel.text = item.author
        cellCreatedLabel.text = item.created.timeAgoDisplay()
        cellCommentsLabel.text = String(item.numberOfComments)
        
      /*  ImageController.shared.downloadImage(with: item.imageUrl, completionHandler: { (image, cached) in
                    self.cellImageView.image = image
                }, placeholderImage: UIImage(named: "placeholder_for_picture"))
 */
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
            return "\(secondsAgo) sec ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) min ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hrs ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }

        return "\(secondsAgo / week) weeks ago"
    }
}

