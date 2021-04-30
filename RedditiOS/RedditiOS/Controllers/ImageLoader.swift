//
//  ImageDownloader.swift
//  RedditiOS
//
//  Created by orpan on 28.04.2021.
//

import Foundation
import UIKit.UIImage
import Combine

public final class ImageLoader {
    public static let shared = ImageLoader()

    private let cache: ImageCacheType
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    public init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }

    private func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .print("Image loading \(url):")
            .subscribe(on: backgroundQueue)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static public func loadImage(_ postItemImage: String) -> AnyPublisher<UIImage?, Never> {
        return Just(postItemImage)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: postItemImage)!
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
}
