//
//  RemoteImage.swift
//  AnonimTest
//
//  Created by Igor Danilchenko on 11.05.2020.
//  Copyright © 2020 Igor Danilchenko. All rights reserved.
//

import SwiftUI

struct RemoteImage: View {
    @ObservedObject var imageLoader = ImageLoader()
    
    var placeholder : Image
    
    init(url : String, placeholder : Image = Image(systemName: ""))
    {
        self.placeholder = placeholder
        imageLoader.fetchImage(url: url)
    }
    
    var body: some View {
        if let image = self.imageLoader.downloadImage {
            return Image(uiImage: image)
        }
        return placeholder
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: "")
    }
}
