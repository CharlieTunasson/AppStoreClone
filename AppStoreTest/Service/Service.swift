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

    // MARK:- Error model
    struct ErrorModel {
        let url: URL?
        let error: Error
    }

    // MARK:- Enums
    enum ErrorType: String, Error {
        case invalidURL = "URL is invalid or nil."
    }

    private func fetchData<T: Decodable>(urlString: String, completion: @escaping(T?, Error?)->()) {

        guard let url = URL(string: urlString) else { completion(nil, ErrorType.invalidURL); return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data!)
                completion(result, nil)
                return
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }

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

    func fetchAppsWeLove(for groupURLs: [URL?], completion: @escaping([AppGroup]?, [ErrorModel])->()) {
        let dispatchGroup = DispatchGroup()
        var groups = [AppGroup]()
        var errors = [ErrorModel]()

        for url in groupURLs {

             dispatchGroup.enter()

            guard let url = url else {
                errors.append(ErrorModel(url: nil, error: ErrorType.invalidURL))
                dispatchGroup.leave();
                continue
            }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    errors.append(ErrorModel(url: url, error: error))
                    dispatchGroup.leave()
                    return
                }

                do {
                    let result = try JSONDecoder().decode(AppGroup.self, from: data!)
                    groups.append(result)
                    dispatchGroup.leave()
                    return
                } catch {
                    errors.append(ErrorModel(url: url, error: error))
                    dispatchGroup.leave()
                    return
                }
            }.resume()
        }

        dispatchGroup.notify(queue: .main) {
            completion(groups, errors)
        }
    }

    func fetchSocialApps(completion: @escaping([SocialApp]?, Error?)->()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"

        fetchData(urlString: urlString, completion: completion)
    }
}
