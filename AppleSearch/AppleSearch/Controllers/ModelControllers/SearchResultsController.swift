//
//  SearchResultsController.swift
//  AppleSearch
//
//  Created by Christopher Alegre on 10/3/19.
//  Copyright © 2019 Christopher Alegre. All rights reserved.
//

import UIKit


class SearchResultsConroller {
    
    struct StringConstants {
        fileprivate static let baseURL = "https://itunes.apple.com"
        fileprivate static let searchComponent = "search"
        fileprivate static let termKey = "term"
        fileprivate static let entityKey = "entity"
        fileprivate static let entityMusic = "musicTrack"
        fileprivate static let entityApp = "software"
    }
    
    static func getMusicItemsWith(searchText: String, completion: @escaping ([MusicSearchResult]) -> Void) {
        guard var url = URL(string: StringConstants.baseURL) else {completion([]); return }
        url.appendPathComponent(StringConstants.searchComponent)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {completion([]); return }
        let searchTermQuery = URLQueryItem(name: StringConstants.termKey, value: searchText)
        let entityQueary = URLQueryItem(name: StringConstants.entityKey, value: StringConstants.entityMusic)
        
        components.queryItems = [searchTermQuery, entityQueary]
        
        guard let finalURL = components.url else {
            print("Components have an issue")
            completion([])
            return }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return }
            
            guard let data = data else {
                print("No data was recieved")
                completion([])
                return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchjson = try jsonDecoder.decode(MusicTopLevelDictionary.self, from: data)
                completion(searchjson.results)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)") }
        } .resume()
    }
    
    static func getAppItemsWith(searchText: String, completion: @escaping ([AppSearchResult]) -> Void) {
        guard var url = URL(string: StringConstants.baseURL) else {completion([]); return }
        url.appendPathComponent(StringConstants.searchComponent)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {completion([]); return }
        let searchQuery = URLQueryItem(name: StringConstants.termKey, value: searchText)
        let entityQuerty = URLQueryItem(name: StringConstants.entityKey, value: StringConstants.entityApp)
        
        components.queryItems = [searchQuery, entityQuerty]
        
        guard let finalURL = components.url else {
            print("The limit does not exist!")
            completion([])
            return }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return }
            
            guard let data = data else {
                print("No data recieved")
                completion([])
                return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let topLevelDict = try jsonDecoder.decode(AppTopLevelDictionary.self, from: data)
                completion(topLevelDict.results)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)") }
        } .resume()
    }
    
    static func getMusicImageFor(item: MusicSearchResult, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = item.artworkUrl100,
            let url = URL(string: imageURL) else {
                print("Item did not have image available at URL provided")
                completion(nil)
                return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(nil)
                return }
            
            guard let data = data else {
                print("No Data")
                completion(nil)
                return }
            
            let image = UIImage(data: data)
            completion(image)
        } .resume()
    }
    
    static func getAppImage(item:AppSearchResult, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = item.artworkUrl100,
            let url = URL(string: imageUrl) else {
                print("Item has no image")
                completion(nil)
                return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(nil)
                return }
            
            guard let data = data else {
                print("No image data")
                completion(nil)
                return }
            
            let image = UIImage(data: data)
            completion(image)
        } .resume()
    }
} //END OF CLASS
