//
//  AlertViewController.swift
//  RedditiOS
//
//  Created by orpan on 29.04.2021.
//

import Foundation
import UIKit

enum AlertType {
    case noInternet
    case saveImage
}

final class AlertController: UIViewController {
    
    private var imageToSave = UIImage()
    var alertType: AlertType?
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var subactionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    public func configureAlertForType(_ type: AlertType,
                               _ image: UIImage? = nil){
        switch type {
        case .noInternet:
            actionButton.titleLabel?.text = "Повторити"
        case .saveImage:
            actionButton.titleLabel?.text = "Зберігти"
            if let imageExists = image {
                self.imageToSave = imageExists
            }
        }
    }
   
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
    }
    @IBAction func subactionButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}


