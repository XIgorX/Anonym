//
//  ImageLoader.swift
//  AnonimTest
//
//  Created by Igor Danilchenko on 11.05.2020.
//  Copyright © 2020 Igor Danilchenko. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var downloadImage: UIImage?
    
    func fetchImage(url : String) {
        
        guard let ImageURL = URL(string: url) else {
            //fatalError("The url string is invalid")
            return
        }
        
        URLSession.shared.dataTask(with: ImageURL) { (data, response, error) in
            guard let data = data, error == nil else {
                //fatalError("Error reading the image")
                return
            }
            
            DispatchQueue.main.async {
                self.downloadImage = UIImage(data: data)
            }
            
        }.resume()
        
    }
}
