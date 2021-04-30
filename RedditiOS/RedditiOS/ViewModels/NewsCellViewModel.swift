//
//  NewsCellViewModel.swift
//  RedditiOS
//
//  Created by orpan on 24.04.2021.
//

import UIKit
import CoreData
import Combine


public class NewsCellViewModel: UITableViewCell{
    
    //MARK: - Outlets
    
    @IBOutlet var cellAuthorLabel: UILabel!
    @IBOutlet var cellTitleLabel: UILabel!
    @IBOutlet var cellDescriptionLabel: UILabel!
    @IBOutlet var cellCreatedLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet var cellCommentsLabel: UILabel!
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?

    override public func prepareForReuse() {
        super.prepareForReuse()
        animator?.stopAnimation(true)
        cancellable?.cancel()
        self.postImageView.image = nil
    }
    
    public override func layoutSubviews() {
         super.layoutSubviews()
      }
    
    func configureCell(item: NewsForView){
        self.cellTitleLabel.text = item.title
        self.cellDescriptionLabel.text = item.newsDescription
        self.cellAuthorLabel.text = "Автор \(item.author)"
        self.cellCreatedLabel.text = item.created.timeAgoDisplay()
        self.cellCommentsLabel.text = "Коментарі: \(String(item.numberOfComments))"
        self.cancellable = ImageLoader.loadImage(item.imageUrl).sink(receiveValue: {
            [weak self] image in
           self!.postImageView.image = image
        })
        self.animator?.stopAnimation(true)
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

