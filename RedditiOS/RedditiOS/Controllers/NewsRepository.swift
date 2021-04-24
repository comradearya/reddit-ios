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
    
    //MARK:- Private Methods
    
    private func stringUrl() -> String {
        let stringUrl = "http://www.reddit.com/r/pics/search.json?q=news&sort=new"
        
        return stringUrl
    }
    
    //MARK:- API Methods
    
    func fetchNewsList(onCompletion: @escaping ([NewsForView]) -> ()) {
        dataTask?.cancel()
        guard let url = URL(string: stringUrl()) else { return }
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
                    for news in news.data.children {
                        let newsForView = NewsForView (
                            title: news.data.title,
                            newsDescription: news.data.selftext,
                            created: Date(timeIntervalSince1970: news.data.created),
                            author: news.data.author,
                            numberOfComments: news.data.num_comments)
                        self.news.append(newsForView)
                    }
                    DispatchQueue.main.async {
                        onCompletion(self.news)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
