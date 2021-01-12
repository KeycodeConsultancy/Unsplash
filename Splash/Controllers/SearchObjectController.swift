//
//  SearchObjectController.swift
//  Splash
//
//  Created by Kevin Reid on 07/01/2021.
//

import Foundation
import SwiftUI

class SearchObjectController : ObservableObject {
    static let shared = SearchObjectController()
    private init() {}
    
    var token = "1TxblPonoVmyHHg57iKGxcj-zBhETiYuEv_lOBpJCUE"
    @Published var results = [Result]()
    @Published var total: Int = 0
    @Published var total_pages: Int = 0
    @Published var searchText : String = "flowers"
    
    func search(nextPage: Int) {
        
        //https://api.unsplash.com/search/collections?page=1&query=office>
        
        let url = URL(string: "https://api.unsplash.com/search/photos?page=\(nextPage)&query=\(searchText)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField:"Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(Results.self, from: data)
               
                DispatchQueue.main.async {
                    self.total = res.total
                    self.total_pages = res.total_pages
                    self.results.append(contentsOf: res.results)
                }
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
