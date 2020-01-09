//
//  URLSession.swift
//  NextUp
//
//  Created by Szymon Lorenz on 9/11/19.
//  Copyright © 2019 Szymon Lorenz. All rights reserved.
//

import Foundation
import Combine

/// Error localized description
enum DataTaskError : Error {
    case unknown
    case urlCreate
    case status(Int, Data?)
    case error(String)
    
    var localizedDescription: String {
        switch self {
        case .urlCreate:
            return "Error while creating request."
        case .status(let code, let data):
            if let data = data, let message = String(data: data, encoding:  .utf8) {
                return "Request ended with error \(message) and status \(code)"
            }
            return "Request ended with error status \(code)"
        case .error(let message):
            return message
        default:
            return "Unknown error."
        }
    }
}

/// HTTPMethod types
public enum HTTPMethod {
    case GET, POST, PUT, PATCH, DELETE, COPY, HEAD, OPTIONS, LINK, UNLINK, PURGE, LOCK, UNLOCK, PROPFIND, VIEW
}

extension URLResponse {
    var httpResponse: HTTPURLResponse? {
        return self as? HTTPURLResponse
    }
}

extension URLRequest {
    /// The HTTP request method. The default HTTP method is “GET”.
    @discardableResult mutating func method(_ method: HTTPMethod) -> Self {
        self.httpMethod = String(describing: method)
        return self
    }
    /// The data sent as the message body of a request, such as for an HTTP POST request.
    @discardableResult mutating func body(_ body: Data?) -> Self {
        self.httpBody = body
        return self
    }
    /// The data sent as the message body of a request, such as for an HTTP POST request.
    @discardableResult mutating func body(_ body: String?) -> Self {
        self.httpBody = body?.data(using: .utf8)
        return self
    }
    /// The HTTP headers sent with a request.
    @discardableResult mutating func headers(_ headers: [String:String]?) -> Self {
        self.allHTTPHeaderFields = headers
        return self
    }
    
    init(urlString: String, parameters: [String : Any]? = nil) throws {
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = parameters?.map({ URLQueryItem(name: $0.key, value: String(describing:$0.value))})
        guard let url = urlComponents?.url else {
            throw  DataTaskError.urlCreate
        }
        self.init(url: url)
    }
}

extension URLSession {
    func data(_ request: URLRequest) -> AnyPublisher<Data, DataTaskError> {
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response.httpResponse else {
                    throw DataTaskError.unknown
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw DataTaskError.status(httpResponse.statusCode, data)
                }
                return data
            }
            .mapError { error in
                if let error = error as? DataTaskError {
                    return error
                } else {
                    return DataTaskError.error(error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func data<T: Decodable>(request: URLRequest) -> AnyPublisher<T, DataTaskError> {
        return data(request)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error -> DataTaskError in
                if let error = error as? DataTaskError {
                    return error
                } else {
                    return DataTaskError.error(error.localizedDescription)
                }
            })
            .eraseToAnyPublisher()
    }
}
