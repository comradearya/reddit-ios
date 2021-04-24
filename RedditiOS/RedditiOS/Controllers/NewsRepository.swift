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
    var news: [News] = []
    private var dataTask: URLSessionDataTask?
    private let defaultSession = URLSession(configuration: .default)
    
    //MARK:- Private Methods
    
    private func stringUrl() -> String {
      /*  let date = Date()
        let currentDate = formatter.string(from: date)*/
        let stringUrl = "http://www.reddit.com/r/pics/search.json?q=news&sort=new"
        
        return stringUrl
    }
    
    //MARK:- API Methods
    
    func fetchNewsList(onCompletion: @escaping (News) -> ()) {
        dataTask?.cancel()
        let session = URLSession.shared
        guard let url = URL(string: stringUrl()) else { return }
        let task = session.dataTask(with: url) { data, response, errror in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
               // self.handleServerError(response)
                return
            }
            guard let mime = response?.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let decoder = JSONDecoder()

                    do {
                        let news = try decoder.decode(News.self, from: data!)
                        DispatchQueue.main.async {
                            onCompletion(news)
                        }
                        
                        print(news)
                    } catch {
                        print(error.localizedDescription)
                    }
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
            
        }
        task.resume()
        
    }
}

//MARK:- Helper
let formatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
}()
