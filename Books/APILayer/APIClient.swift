//
//  APIClient.swift
//  Books
//
//  Created by Dmitrii on 20/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import Foundation

typealias RequestCompletion = (Any?, Error?) -> ()

class APIClient {

    // MARK: - Properties
    private let queue = DispatchQueue(label: "APIRequestsQueue")
    private lazy var session: URLSession = URLSession(configuration: .default)

    func getBooks(query: String, startIdx: UInt, amount: UInt, completion: @escaping RequestCompletion) {
        queue.sync {
            let url = URL(string: urlString(query: query, startIdx: startIdx, amount: amount))!
            let request = URLRequest(url: url)
            let task = session.dataTask(
                with: request,
                completionHandler: { [weak self] (data, response, error) in
                    self?.processResponse(responseData: data, error: error, completion: completion)
            })
            task.resume()
        }
    }


    // MARK: - Private
    private func urlString(query: String, startIdx: UInt, amount: UInt) -> String {
        return "https://www.googleapis.com/books/v1/volumes?q=\(query)&maxResults=\(amount)&startIndex=\(startIdx)"
    }

    private func processResponse(responseData: Data?, error: Error?, completion: RequestCompletion) {
        if responseData != nil {
            do {
                let resp = try JSONSerialization.jsonObject(
                    with: responseData!,
                    options: JSONSerialization.ReadingOptions.mutableContainers
                )
                completion(resp, nil)
            } catch {
                print("Error. JSON Serialization")
                //let err = NSError(domain: <#T##String#>, code: <#T##Int#>, userInfo: <#T##[AnyHashable : Any]?#>)
                //completion(nil, err)
            }
        } else {
            completion(nil, error)
        }
    }
}
