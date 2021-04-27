//
//  NewsRepository.swift
//  RedditiOS
//
//  Created by orpan on 24.04.2021.
//

import Foundation

final class NewsRepository {
    
    //MARK:- Properties
    
    static let shared = NewsRepository()
    private var news: [NewsForView] = []
    private var dataTask: URLSessionDataTask?
    private let defaultSession = URLSession(configuration: .default)
    private var infoElements : PageInfo = (firstId: "", lastId: "")
    
    //MARK:- Private Methods
    
    private func stringUrl(toRefresh: Bool) -> URL {
        var urlComponents: URLComponents {
            var urlComponents = URLComponents()
            urlComponents.scheme = "http"
            urlComponents.host = "www.reddit.com"
            urlComponents.path = "/r/memes/top.json"            
            if toRefresh {
                urlComponents.queryItems = [
                    URLQueryItem(name: "sort", value: "new"),
                    URLQueryItem(name: "t", value: "hour"),
                    URLQueryItem(name: "limit", value: "5")]
            }
            else {
                urlComponents.queryItems = [
                    URLQueryItem(name: "after", value: "\(infoElements.lastId)"),
                    URLQueryItem(name: "sort", value: "new"),
                    URLQueryItem(name: "t", value: "hour"),
                    URLQueryItem(name: "limit", value: "5")
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
        let task = defaultSession.dataTask(with: url) { data, response, errror in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // self.handleServerError(response)
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
                    for newsElement in news.data.children {
                        let newsForView = NewsForView (
                            title: newsElement.data.title,
                            newsDescription: newsElement.data.selftext,
                            created: self.formateDate(dateCreated: Double(newsElement.data.created)),
                            author: newsElement.data.authorFullname,
                            numberOfComments: newsElement.data.numComments,
                            imageUrl: newsElement.data .preview.images.first?.source.url ?? "")
                        self.news.append(newsForView)
                    }
                    self.infoElements.lastId = news.data.after
                    onCompletion(Swift.Result.success(self.news))
                } catch {
                    print(error.localizedDescription)
                    onCompletion(Swift.Result.failure(error))
                }
            }
        }
        task.resume()
    }
    
    private func formateDate(dateCreated: Double) -> Date {
        let timezoneEpochOffset = (dateCreated - 28800)
        return Date(timeIntervalSince1970: timezoneEpochOffset)
    }
}


