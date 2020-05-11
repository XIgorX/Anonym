//
//  NetworkManager.swift
//  AnonimTest
//
//  Created by Igor Danilchenko on 10.05.2020.
//  Copyright © 2020 Igor Danilchenko. All rights reserved.
//

import UIKit

struct Response: Codable {
    var data: Data
}

struct Data: Codable {
    var items: [Item]
    var cursor: String
}

struct Item: Codable {
    var id: String
    var replyOnPostId: String?
    var type: String
    var thankedComment: String?
    var status: String
    var hidingReason: String?
//    var coordinates: Coordinates
    var isCommentable: Bool
    var hasAdultContent: Bool
    var isAuthorHidden: Bool
    var isHidden: Bool
    var contents: [Content]
    var language: String
    var createdAt: Int
    var updatedAt: Int
    var page: Int?
    //var author: Author
    //var stats: Stats
    var isMyFavorite: Bool
    
}

struct Coordinates: Codable {
    var latitude: Double
    var longitude: Double
    var zoom: Int?
}

struct Content: Codable {
    var type: String
    var data: ContentData
}

struct ContentData: Codable {
    var value: String?
    var extraSmall: Picture?
    var small: Picture?
}

struct Picture: Codable {
    var url: String
    var size : Size
}

struct Size: Codable {
    var width: Int
    var height : Int
}

class NetworkManager: NSObject {
    
    func getPosts(first : Int = 20, after : String? = nil, completion: @escaping ([Item]?, String) -> ())
    {
        var urlString = ""
        if let after = after
        {
            urlString = "\(baseUrl)?first=\(first)&after=\(after)"
        }
        else
        {
            urlString = "\(baseUrl)?first=\(first)"
        }
        
        if let url = URL(string: urlString) {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  let jsonString = String(data: data, encoding: .utf8)
                  if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                      // we have good data – go back to the main thread
                      DispatchQueue.main.async {
                          // update our UI
                        completion(decodedResponse.data.items, decodedResponse.data.cursor)
                      }

                      // everything is good, so we can exit
                      return
                  }
                  else
                  {
                    //fatalError(error?.localizedDescription ?? jsonString ?? "")
                    print(error?.localizedDescription ?? jsonString ?? "nil")
                  }
              }
           }.resume()
        }
    }

}
