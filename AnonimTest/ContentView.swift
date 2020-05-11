//
//  ContentView.swift
//  AnonimTest
//
//  Created by Igor Danilchenko on 09.05.2020.
//  Copyright © 2020 Igor Danilchenko. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var selectedImage: String
    var fullText: String
    
    var body: some View {
        VStack
        {
            RemoteImage(url: selectedImage)
            Text(fullText)
        }
    }
}

struct ContentView: View {
    
    @State private var items = [Item]()
    @State private var cursor : String?
    
    var body: some View {
        NavigationView
        {
        VStack
        {
            List(items, id: \.id) { item in
                NavigationLink(
                destination: DetailView(selectedImage: item.contents[0].data.small?.url ?? item.contents[1].data.small?.url ?? "", fullText: item.contents[0].data.value ?? item.contents[1].data.value ?? "")) {
                     Text(item.contents[0].data.value ?? "")
                     .lineLimit(10)
                     RemoteImage(url: item.contents[0].data.extraSmall?.url ?? "")
                     Text(item.contents[1].data.value ?? "")
                     .lineLimit(10)
                     RemoteImage(url: item.contents[1].data.extraSmall?.url ?? "")
                }
            }
            Button(action: {
                // What to perform
                self.loadData()
            }) {
                // How the button looks like
                Text("Show more")
            }
            .opacity(cursor != nil ? 1 : 0)
        }
        .onAppear(perform: loadData)
        .navigationBarTitle(Text("Anonim"))
        }
    }
    
    func loadData() {
        let networkManager = NetworkManager()
        
        networkManager.getPosts(first: numberOfPostsInPortion, after: cursor) { (results, cursor) in
            if let results = results
            {
                 DispatchQueue.main.async {
                    // update our UI
                    self.items = results
                    self.cursor = cursor
                    //if cursor == nil {  }
                 }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
