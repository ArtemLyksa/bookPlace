//
//  SearchService.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/8/17.
//  Copyright © 2017 Artem Lyksa. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let sharedInstace = NetworkService()
    private init() {}
    
    func getBookListWithString(searchString: String, completionHandler: @escaping ([String: AnyObject]?, Error?) -> ()) -> () {
        let params = [
            "q" : searchString,
            "maxResults" : "40",
            "projection" : "lite"
        ]
        
        let dataRequest = Alamofire.request(APIRouter.getBooks(params))
        dataRequest.response { (response) in
            do {
                if let dataResp = response.data,
                    let json = try JSONSerialization.jsonObject(with: dataResp, options: []) as? [String: AnyObject] {
                    completionHandler(json, nil)
                } else {
                    completionHandler(nil, response.error)
                }
            } catch {
                print("Error when trying convert data to json")
                completionHandler(nil, response.error)
            }
        }
        dataRequest.resume()
    }
}
