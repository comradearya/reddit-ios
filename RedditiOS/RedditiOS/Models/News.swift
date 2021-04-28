// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try News(json)

//
// To read values from URLs:
//
//   let task = URLSession.shared.newsTask(with: url) { news, response, error in
//     if let news = news {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - News
struct News: Codable {
    let data: NewsData
}

// MARK: News convenience initializers and mutators

extension News {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(News.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        data: NewsData? = nil
    ) -> News {
        return News(
            data: data ?? self.data
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.newsDataTask(with: url) { newsData, response, error in
//     if let newsData = newsData {
//       ...
//     }
//   }
//   task.resume()

// MARK: - NewsData
struct NewsData: Codable {
    let children: [Child]
    let after: String
}

// MARK: NewsData convenience initializers and mutators

extension NewsData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NewsData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        children: [Child]? = nil,
        after: String? = nil
    ) -> NewsData {
        return NewsData(
            children: children ?? self.children,
            after: after ?? self.after
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.childTask(with: url) { child, response, error in
//     if let child = child {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Child
struct Child: Codable {
    let data: ChildData
}

// MARK: Child convenience initializers and mutators

extension Child {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Child.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        data: ChildData? = nil
    ) -> Child {
        return Child(
            data: data ?? self.data
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.childDataTask(with: url) { childData, response, error in
//     if let childData = childData {
//       ...
//     }
//   }
//   task.resume()

// MARK: - ChildData
struct ChildData: Codable {
    let selftext, title: String
    let thumbnail: String
    let numComments: Int
    let authorFullname: String
    let created: Int
    let permalink: String

    enum CodingKeys: String, CodingKey {
        case selftext, title, thumbnail
        case numComments = "num_comments"
        case authorFullname = "author_fullname"
        case created, permalink
    }
}

// MARK: ChildData convenience initializers and mutators

extension ChildData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ChildData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        selftext: String? = nil,
        title: String? = nil,
        thumbnail: String? = nil,
        numComments: Int? = nil,
        authorFullname: String? = nil,
        created: Int? = nil,
        permalink: String? = nil
    ) -> ChildData {
        return ChildData(
            selftext: selftext ?? self.selftext,
            title: title ?? self.title,
            thumbnail: thumbnail ?? self.thumbnail,
            numComments: numComments ?? self.numComments,
            authorFullname: authorFullname ?? self.authorFullname,
            created: created ?? self.created,
            permalink: permalink ?? self.permalink
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func newsTask(with url: URL, completionHandler: @escaping (News?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
