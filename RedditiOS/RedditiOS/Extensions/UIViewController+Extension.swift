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
            alert.title = "Зображення"
            let action = UIAlertAction(title: "Зберігти", style: .default) { _ in
                actionHandler()
            }
            alert.addAction(action)
      
        case .noInternet:
            alert.title = "Упс!"
            alert.message = "Нема звязку"
            let action = UIAlertAction(title: "Перезавантажити", style: .default) {_ in
                actionHandler()
            }
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}


extension UIViewController {
    internal func addImageSubview(_ image: UIImage){
        let newImageView = UIImageView(image: image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    
    @objc private func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
