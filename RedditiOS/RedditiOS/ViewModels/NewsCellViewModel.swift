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
        imageView?.image = nil
        imageView?.alpha = 0.0
        animator?.stopAnimation(true)
        cancellable?.cancel()
    }
    func configureCell(item: NewsForView){
        //DispatchQueue.main.async {
            self.cellTitleLabel.text = item.title
            self.cellDescriptionLabel.text = item.newsDescription
            self.cellAuthorLabel.text = "Автор \(item.author)"
            self.cellCreatedLabel.text = item.created.timeAgoDisplay()
            self.cellCommentsLabel.text = "Коментарі: \(String(item.numberOfComments))"
            self.cancellable = self.loadImage(for: item).sink {
                [unowned self] image in
                self.showImage(image: image)
            }
       /*
            ImageController.shared.downloadImage(
                with: item.imageUrl,
                completionHandler :{
                    (image, cached) in
                    self.postImageView.image = image },
                placeholderImage: UIImage(
                    named: "placeholder_profile_pic"))*/
        animator?.stopAnimation(true)
    }
}

extension NewsCellViewModel {
    private func showImage(image: UIImage?){
        self.postImageView.alpha = 0.0
        animator?.stopAnimation(false)
        self.postImageView.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3,
                                                                  delay: 0,
                                                                  options: .curveLinear,
                                                                  animations: {
                                                                    self.postImageView.alpha = 1.0
                                                                  })

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

