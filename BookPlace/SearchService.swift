//
//  SearchService.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/8/17.
//  Copyright © 2017 Artem Lyksa. All rights reserved.
//

import Foundation
import Alamofire

class SearchService {
    
    static let sharedInstace = SearchService()
    private init() {}
    
    func getBookListWithString(searchString: String, completionHandler: @escaping ([String: AnyObject]?, Error?) -> ()) -> () {
        let params = [
            "q" : searchString,
            "maxResults" : "40",
            "projection" : "lite"
        ]
        
        let dataRequest = Alamofire.request(BooksRouter.getBooks(params))
        dataRequest.response { (response) in
            do {
                if let dataResp = response.data,
                    let json = try JSONSerialization.jsonObject(with: dataResp, options: []) as? [String: AnyObject] {
                    completionHandler(json, nil)
                }
                completionHandler(nil, response.error)
            } catch {
                print("Error when trying convert data to json")
                completionHandler(nil, response.error)
            }
        }
        dataRequest.resume()
    }
}
