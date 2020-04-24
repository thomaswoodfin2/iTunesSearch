//
//  SearchResponse.swift
//  TestApp
//
//  Created by Thomas Woodfin on 4/24/20.
//  Copyright © 2020 Thomas Woodfin. All rights reserved.
//

import ObjectMapper

struct SearchResponse: Mappable {
    
    var searchList: [SearchData]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        searchList <- map["results"]
    }
}

struct SearchData: Mappable{

    var wrapperType: String?
    var kind: String?
    var artistID, collectionID, trackID: Double?
    var artistName, collectionName, trackName, collectionCensoredName: String?
    var trackCensoredName: String?
    var artistViewURL, collectionViewURL, trackViewURL: String?
    var previewURL: String?
    var artworkUrl30, artworkUrl60, artworkUrl100: String?
    var collectionPrice, trackPrice: Double?
    var releaseDate: Date?
    var collectionExplicitness, trackExplicitness: String?
    var discCount: Int?
    var discNumber: Int?
    var trackCount: Int?
    var trackNumber: Int?
    var trackTimeMillis: Int?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    var isStreamable: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        wrapperType <- map["wrapperType"]
        kind <- map["kind"]
        artistID <- map["artistID"]
        collectionID <- map["collectionID"]
        trackID <- map["trackID"]
        collectionCensoredName <- map["collectionCensoredName"]
        trackName <- map["trackName"]
        collectionName <- map["collectionName"]
        artistName <- map["artistName"]
        trackCensoredName <- map["trackCensoredName"]
        artistViewURL <- map["artistViewURL"]
        collectionViewURL <- map["collectionViewURL"]
        trackViewURL <- map["trackViewURL"]
        previewURL <- map["previewURL"]
        artworkUrl30 <- map["artworkUrl30"]
        artworkUrl60 <- map["artworkUrl60"]
        artworkUrl100 <- map["artworkUrl100"]
        collectionPrice <- map["collectionPrice"]
        trackPrice <- map["trackPrice"]
        releaseDate <- map["releaseDate"]
        collectionExplicitness <- map["collectionExplicitness"]
        trackExplicitness <- map["trackExplicitness"]
        discCount <- map["discCount"]
        discNumber <- map["discNumber"]
        trackCount <- map["trackCount"]
        trackNumber <- map["trackNumber"]
        trackTimeMillis <- map["trackTimeMillis"]

        country <- map["country"]
        currency <- map["currency"]
        primaryGenreName <- map["primaryGenreName"]
        isStreamable <- map["isStreamable"]

    }
}

