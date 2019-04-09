//
//  Service.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-07.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import Foundation

class Service {

    static let shared = Service()

    func fetchApps(for term: String, completion: @escaping([Result], Error?)->()) {
        let urlString = "http://itunes.apple.com/search?term=\(term)&entity=software"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
               completion([], error)
                return
            }

            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: data!)
                completion(result.results, nil)
            } catch {
                completion([], error)
            }
        }.resume()
    }

}
