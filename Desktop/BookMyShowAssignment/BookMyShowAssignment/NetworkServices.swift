//
//  NetworkServices.swift
//  BookMyShowAssignment
//
//  Created by Sourabh Kumbhar on 11/10/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation


class NetworkServices {
    
    func fetchMovieList(pageNo: String = "1", completion: @escaping(_ success: Bool, _ message: String?, _ response: Movie?)-> ()) {
        // Create url
        let urlString = ConstantURL.baseURL + ConstantURL.nowPlayingUrl + ConstantKey.apikey + "=" + ConstantURL.apiKey + "&" + ConstantKey.page + "=" + pageNo
        guard let url = URL(string: urlString) else {
            completion(false, ConstantKey.urlInvalid, nil)
            return
        }
        
        // Create url request
        var requst = URLRequest(url: url)
        
        // Set http method
        requst.httpMethod = "GET"
        
        // Create Session
        let session = URLSession.shared
        
        // Create datatask
        let dataTask = session.dataTask(with: requst, completionHandler: {
            (data, response, error)->Void in
            print("Data",data)
            print("Response", response)
            print("Error",error)
            if error != nil {
                completion(false, error?.localizedDescription, nil)
                return
            }
            if let convertData = data {                
                do {
                    // Parsing data using codable and pass data to viewcontroller through completion
                    let movieResponse = try? JSONDecoder().decode(Movie.self, from: convertData)
                    completion(true, nil, movieResponse)
                } catch let error {
                    // Handle error 
                    completion(false, error.localizedDescription, nil)
                }
            } else {
                completion(false, ConstantKey.somethingWentWrong, nil)
            }
        })
        dataTask.resume()
    }
}
