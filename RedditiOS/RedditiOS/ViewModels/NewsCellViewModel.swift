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

    @IBOutlet var cellTitleLabel: UILabel!
    @IBOutlet var cellDescriptionLabel: UILabel!
   // @IBOutlet weak var cellImageView: UIImageView!

    //MARK: - Public Methods

    func configureCell(item: NewsForView){
        cellTitleLabel.text = item.title
        cellDescriptionLabel.text = item.newsDescription
      /*  ImageController.shared.downloadImage(with: item.imageUrl, completionHandler: { (image, cached) in
                    self.cellImageView.image = image
                }, placeholderImage: UIImage(named: "placeholder_for_picture"))
 */
    }
}

