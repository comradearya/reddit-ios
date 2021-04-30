//
//  UIViewController.swift
//  RedditiOS
//
//  Created by orpan on 29.04.2021.
//

import UIKit
import Combine

//MARK: - Extension for Alerts

extension UIViewController {
    
    //MARK: - Enum
    
    enum AlertType {
        case saveImage
        case noInternet
    }
    
    //MARK: - Internal Methods
    
    internal func showAlert(_ type: AlertType, actionHandler: @escaping ()->()) {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        switch type {
        case .saveImage:
            alert.title = Localization.Alert.Title.save
            let saveAction = UIAlertAction(title: Localization.Alert.Button.save, style: .default) { _ in
                actionHandler()
            }
            alert.addAction(saveAction)
            
        case .noInternet:
            alert.title = Localization.Alert.Title.network
            alert.message = Localization.Alert.Message.network
            let reloadAction = UIAlertAction(title:Localization.Alert.Button.reload, style: .default) {_ in
                actionHandler()
            }
            alert.addAction(reloadAction)
        }
        let cancelAction = UIAlertAction(title: Localization.Alert.Button.cancel, style: .cancel)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}


extension UIViewController {
    internal func addImageSubview(_ imageUrl: String){
        ImageLoader.loadImage(imageUrl).sink { [unowned self]
            image in
            guard let imageExists = image else {return }
            let newImageView = UIImageView(image: image)
            newImageView.frame = UIScreen.main.bounds
            newImageView.backgroundColor = .black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            
            self.showAlert(.saveImage, actionHandler: {
                UIImageWriteToSavedPhotosAlbum(imageExists, nil, nil, nil)
            })
        }
    }
    
    @objc private func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
