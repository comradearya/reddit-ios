//
//  NewsRepository.swift
//  RedditiOS
//
//  Created by orpan on 24.04.2021.
//

import Foundation
import CoreData
import UIKit

final class NewsRepository {
    
    //MARK:- Properties
    
    static let shared = NewsRepository()
    private var news: [NewsForView] = []
    private var dataTask: URLSessionDataTask?
    private let defaultSession = URLSession(configuration: .default)
    private var lastElementId = String()
    
    //MARK:- Private Methods
    
    private func stringUrl(toRefresh: Bool) -> URL {
        var urlComponents: URLComponents {
            var urlComponents = URLComponents()
            urlComponents.scheme = NetworkConfiguration.scheme
            urlComponents.host = NetworkConfiguration.hostUrl
            urlComponents.path = NetworkConfiguration.pathUrl
            if toRefresh {
                urlComponents.queryItems = [
                    URLQueryItem(name: "sort", value: "new"),
                    URLQueryItem(name: "t", value: "hour"),
                    URLQueryItem(name: "limit", value: "\(NetworkConfiguration.limit)")]
            }
            else {
                urlComponents.queryItems = [
                    URLQueryItem(name: "after", value: "\(lastElementId)"),
                    URLQueryItem(name: "sort", value: "new"),
                    URLQueryItem(name: "t", value: "hour"),
                    URLQueryItem(name: "limit", value: "\(NetworkConfiguration.limit)")
                ]
            }
            return urlComponents
        }
        print(urlComponents.url!)
        return (urlComponents.url)!
    }
    
    
    //MARK:- API Methods
    
    func loadData(needToRefresh: Bool = true, onCompletion: @escaping (Swift.Result<[NewsForView], Error>) -> Void) {
        dataTask?.cancel()
        let url = stringUrl(toRefresh: needToRefresh)
        if needToRefresh {
            self.news.removeAll()
        }
        let task = defaultSession.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    onCompletion(Swift.Result.failure(error!))
                }
                return
            }
            guard let mime = response?.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            do {
                let decoder = JSONDecoder()
                do {
                    let news = try decoder.decode(News.self, from: data!)
                    self.decodePosts(from: news)
                    self.lastElementId = news.data.after
                    DispatchQueue.main.async {
                        onCompletion(Swift.Result.success(self.news))
                    }
                } catch {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        onCompletion(Swift.Result.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
}

// MARK: - Decoding Extensions

extension NewsRepository {
    
    private func decodePosts(from news: News) {
        for newsElement in news.data.children {
            let newsForView = NewsForView (
                title: newsElement.data.title,
                newsDescription: newsElement.data.selftext,
                created: self.formateDate(dateCreated: Double(newsElement.data.created)),
                author: newsElement.data.authorFullname,
                numberOfComments: newsElement.data.numComments,
                imageUrl: newsElement.data.thumbnail ?? "",
                postUrl: newsElement.data.permalink
                )
            self.news.append(newsForView)
        }
    }
    
    private func formateDate(dateCreated: Double) -> Date {
        let timezoneEpochOffset = (dateCreated - 28800)
        return Date(timeIntervalSince1970: timezoneEpochOffset)
    }
}


