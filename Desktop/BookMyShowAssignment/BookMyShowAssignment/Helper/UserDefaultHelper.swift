//
//  UserDefaultHelper.swift
//  BookMyShowAssignment
//
//  Created by Sourabh Kumbhar on 11/10/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation


class UserDefaultHelper {
    
    static let defaults = UserDefaults.standard
    
    class func storeRecentSearchMoviw(movie: Result) {
        let encoder = JSONEncoder()
        if let savedMovie = defaults.object(forKey: ConstantKey.saveMovie) as? Data {
            let decoder = JSONDecoder()
            // Firstly get movies from user default and add newly movie in it
            if var movies = try? decoder.decode([Result].self, from: savedMovie) {
                // Check condition for movie already exist in userdefault or not
                if movies.contains(where: { $0.id == movie.id } ) {
                    let filterArray = movies.map { $0.id! }
                    if let index = filterArray.index(of: movie.id!) {
                        movies.remove(at: index)
                        movies.insert(movie, at: 0)
                    }
                } else {
                    movies.insert(movie, at: 0)
                }
                // If recent searches more than 5 then remove first history
                if movies.count > 5 {
                    movies.removeLast()
                }
                // Encode the model class and save in user default
                if let encoded = try? encoder.encode(movies) {
                    defaults.set(encoded, forKey: ConstantKey.saveMovie)
                }
            } else {
                // Where no data found in userdefault
                var movies = Array<Result>()
                movies.insert(movie, at: 0)
                // Encode the model class and save in user default
                if let encoded = try? encoder.encode(movies) {
                    defaults.set(encoded, forKey: ConstantKey.saveMovie)
                }
            }
        } else {
            // Where no data found in userdefault
            var movies = Array<Result>()
            movies.insert(movie, at: 0)
            // Encode the model class and save in user default
            if let encoded = try? encoder.encode(movies) {
                defaults.set(encoded, forKey: ConstantKey.saveMovie)
            }
        }
    }
    
    class func getRecentSearchMovie()->Array<Result> {
        var movies = Array<Result>()
        // Fetch data from userdefaults
        if let savedMovie = defaults.object(forKey: ConstantKey.saveMovie) as? Data {
            let decoder = JSONDecoder()
            // Decode into model class 
            if let movieArray = try? decoder.decode([Result].self, from: savedMovie) {
                movies = movieArray
            }
        }
        return movies
    }
}
