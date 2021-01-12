//
//  ContentView.swift
//  Splash
//
//  Created by Kevin Reid on 07/01/2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var searchObjectController = SearchObjectController.shared
    @State private var nextPage: Int = 1
    var body: some View {
       
        List {
            ForEach(0..<searchObjectController.results.count, id: \.self) { index in
                HStack(alignment: .top) {
                    AsyncImage(url: URL(string: searchObjectController.results[index].urls.small)!, placeholder: {Color.black}, image: { image in
                    Image(uiImage: image).resizable()
                }).aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        if let userName = searchObjectController.results[index].user.name, let id = searchObjectController.results[index].user.id, let likes = searchObjectController.results[index].likes {
                            Text(id)
                            Text(userName).bold()
                            Text(String(likes))
                            Text(String(searchObjectController.total))
                            Text(String(searchObjectController.total_pages))
                            
                        }
                      
                    }.onAppear() {
                        if index == self.searchObjectController.results.count - 3 {
                            nextPage += 1
                            searchObjectController.search(nextPage: nextPage)
                        }
                    }
                    
                }
            }
            
        }.onAppear() {
            searchObjectController.search(nextPage: 1)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
