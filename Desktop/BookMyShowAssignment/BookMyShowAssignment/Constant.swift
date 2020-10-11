//
//  Constant.swift
//  BookMyShowAssignment
//
//  Created by Sourabh Kumbhar on 11/10/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation

class ConstantURL {
    static let baseURL = "https://api.themoviedb.org/3"
    static let nowPlayingUrl = "/movie/now_playing?"
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "be745ff0e61a927a93cf7b8ca3bdf7cc"    
}

class ConstantKey {
    static let ts = "ts"
    static let apikey = "api_key"
    static let page = "page"
    static let hash = "hash"
    static let ok = "Ok"
    static let noDataFound = "No data found ☹️"
    static let error = "Error"
    static let fetchingData = "Fetching data"
    static let status = "status"
    static let data = "data"
    static let results = "results"
    static let title = "title"
    static let description = "description"
    static let thumbnail = "thumbnail"
    static let path = "path"
    static let `extension` = "extension"
    static let character = "character"
    static let characters = "characters"
    static let items = "items"
    static let resourceURI = "resourceURI"
    static let name = "name"
    static let urlInvalid = "Url is not valid"
    static let main = "Main"
    static let somethingWentWrong = "Something went wrong"
    static let dataCannotConvert = "data cannot converted"
    static let descriptionNotFound = "Description not found"
    static let english = "English"
    static let italian = "Italian"
    static let japanese = "Japanese"
    static let korean = "Korean"
    static let na = "NA"
    static let saveMovie = "savemovie"
    static let recentlySearched = "Recently searched"
    static let noSearchMessage = "User hasn’t yet searched for a movie"
}

class TableCellConstant {
    static let movieListTableViewCell = "movieListTableViewCell"
    static let recentSearchTableViewCell = "recentSearchTableViewCell"
}

class ViewControllerIdentifierConstant {
    static let movieListVC = "movieListVC"
    static let movieDetailsVC = "movieDetailsVC"
    static let searchScreenVC = "searchScreenVC"
}

