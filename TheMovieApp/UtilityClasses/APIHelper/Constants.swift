//
//  Constants.swift
//  TheMovieApp
//
//  Created by Chandra Rao on 26/06/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

import Foundation

class Constants {
 
    //Please change the URLS
    static let BASEURL = "https://api.themoviedb.org/3/"
    static let ImageBASEURL = "https://image.tmdb.org/t/p/w300"
    static let EnterApiKey = "api_key"
    static let APIKey = "920cf4b3097a290f416ca654ae3b2537"
    static let PopularMovies = "movie/popular?"
    static let SearchMovies = "search/movie?"
    static let LanguageKey = "language"
    static let AdultKey = "include_adult"
    static let PageKey = "page"
    static let LanguageEng = "en-US"
    static let HTTPMethodGet = "GET"
    static let HTTPMethodPOST = "POST"
    static let ContentType = "Content-Type"
    static let AuthorisationKey = "Authorization"
    static let AcceptKey = "Accept"
    static let ContentTypeURLEncoded = "application/x-www-form-urlencoded; charset=utf-8"
    static let ContentTypeJSON = "application/json"
    
    static let OriginalTitle = "original_title"
    static let BackgroundImage = "backdrop_path"
    static let Placeholder = "placeholder"
    static let ReleaseDateKey = "release_date"
    static let ResultsKey = "results"
    static let PopularityKey = "popularity"
    static let VoteAverageKey = "vote_average"
    static let OverviewKey = "overview"
    static let DateKey = "date"
    static let AlertKey = "Alert!"
    static let ProblemOccuredMsg = "Some problem occured, PLease try again after some time."
    
}
