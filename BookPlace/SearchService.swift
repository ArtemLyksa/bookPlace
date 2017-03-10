//
//  SearchService.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/8/17.
//  Copyright © 2017 Artem Lyksa. All rights reserved.
//

import Foundation

class SearchService {
    
    static let sharedInstace = SearchService()
    private init() {}
    
     func getBookListWithString(searchString: String, completionHandler: @escaping ([String: AnyObject]?, Error?) -> ()) -> () {
        let url = createURLWithComponents(searchString: searchString)
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                do {
                    if let dataResp = data,
                        let json = try JSONSerialization.jsonObject(with: dataResp, options: []) as? [String: AnyObject] {
                        completionHandler(json, nil)
                    }
                    completionHandler(nil, error)
                } catch {
                    print("Error when trying convert data to json")
                    completionHandler(nil, error)
                }
            }
        task.resume()
    }
    
     func createURLWithComponents(searchString: String) -> (URL) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.googleapis.com"
        urlComponents.path = "/books/v1/volumes"
        let searchQuery = URLQueryItem(name: "q", value: searchString)
        let maxResult = URLQueryItem(name: "maxResults", value: "40")
        let projection = URLQueryItem(name: "projection", value: "lite")
        urlComponents.queryItems = [searchQuery, maxResult, projection]
        return urlComponents.url!
    }
}
