//
//  Network.swift
//  RedditiOS
//
//  Created by orpan on 26.04.2021.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class NetworkManager {

    // MARK: - Properties

    private var session: URLSession!
    
    // MARK: - Initializer

    init() {
        session = URLSession(configuration: .ephemeral)
    }
    
    deinit {
        cancelAllTask()
    }
    
    // MARK: - Public Methods

    public func dataTaskFromURL<T: Decodable>(_ url: URL, completion: @escaping ((Result<T>) -> Void)) -> URLSessionDataTask {
                
        return session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error == nil,
                let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch let parsingError {
                    completion(.failure(parsingError))
                }
            } else {
                completion(.failure(error!))
            }
        })
    }
    
    public func cancelAllTask() {
        session.invalidateAndCancel()
    }
}
