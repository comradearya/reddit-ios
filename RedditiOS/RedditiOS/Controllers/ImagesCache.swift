//
//  ImagesCache.swift
//  RedditiOS
//
//  Created by orpan on 29.04.2021.
//

import Foundation
import UIKit

class ImagesCache {
    
    static func storeImage(urlString: String, img: UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath:  path)
        
        let data = img.jpegData(compressionQuality: 1)
        try? data?.write(to: url)
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String]
        if dict == nil {
            dict = [String: String]()
        }
        dict![urlString] = path
        UserDefaults.standard.setValue(dict, forKey: "ImageCache")
    }
    
    static func loadImage(urlString: String, completion: @escaping (String, UIImage?) -> Void){
        
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String] {
            if let path = dict[urlString], let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                let imageData = UIImage(data: data)
                completion(urlString, imageData)
            }
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url){
            (data, response,error) in
            guard error == nil else {return }
            guard let dataExists  = data else {return }
            DispatchQueue.main.async {
                if let image = UIImage(data: dataExists){
                    storeImage(urlString: urlString, img: image)
                    completion(urlString, image)
                }
            }
        }
        task.resume()
    }
}
