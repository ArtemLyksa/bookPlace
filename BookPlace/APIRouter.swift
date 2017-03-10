//
//  Router.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/10/17.
//  Copyright © 2017 Artem Lyksa. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    static let baseURLString = "https://www.googleapis.com/books/v1/volumes"
    case getBooks([String: Any])
    case create([String: Any])
    case delete(Int)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getBooks:
                return .get
            case .create:
                return .post
            case .delete:
                return .delete
            }
        }
        let params: ([String: Any]?) = {
            switch self {
            case .getBooks(let searchParams):
                return (searchParams)
            case .delete:
                return nil
            case .create(let newTodo):
                return (newTodo)
            }
        }()
        let url: URL = {
            let url = URL(string: APIRouter.baseURLString)!
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        let encoding = Alamofire.URLEncoding()
        return try encoding.encode(urlRequest, with: params)
    }
}










