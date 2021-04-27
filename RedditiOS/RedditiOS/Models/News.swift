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
       // before: String
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
     //   before: String? = nil
    ) -> NewsData {
        return NewsData(
            children: children ?? self.children,
            after: after ?? self.after
           // before: before ?? self.before
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
    let preview: Preview
    let numComments: Int
    let authorFullname: String
    let created: Int

    enum CodingKeys: String, CodingKey {
        case selftext, title, preview
        case numComments = "num_comments"
        case authorFullname = "author_fullname"
        case created
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
        preview: Preview? = nil,
        numComments: Int? = nil,
        authorFullname: String? = nil,
        created: Int? = nil
    ) -> ChildData {
        return ChildData(
            selftext: selftext ?? self.selftext,
            title: title ?? self.title,
            preview: preview ?? self.preview,
            numComments: numComments ?? self.numComments,
            authorFullname: authorFullname ?? self.authorFullname,
            created: created ?? self.created
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
//   let task = URLSession.shared.previewTask(with: url) { preview, response, error in
//     if let preview = preview {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Preview
struct Preview: Codable {
    let images: [SourceImage]
}

// MARK: Preview convenience initializers and mutators

extension Preview {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Preview.self, from: data)
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
        images: [SourceImage]? = nil
    ) -> Preview {
        return Preview(
            images: images ?? self.images
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
//   let task = URLSession.shared.imageTask(with: url) { image, response, error in
//     if let image = image {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Image
struct SourceImage: Codable {
    let source: Source
}

// MARK: Image convenience initializers and mutators

extension SourceImage {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SourceImage.self, from: data)
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
        source: Source? = nil
    ) -> SourceImage {
        return SourceImage(
            source: source ?? self.source
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
//   let task = URLSession.shared.sourceTask(with: url) { source, response, error in
//     if let source = source {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Source
struct Source: Codable {
    let url: String
}

// MARK: Source convenience initializers and mutators

extension Source {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Source.self, from: data)
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
        url: String? = nil
    ) -> Source {
        return Source(
            url: url ?? self.url
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
