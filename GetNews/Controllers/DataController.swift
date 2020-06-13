//
//  DataController.swift
//  GetNews
//
//  Created by Anuranjan Bose on 14/06/20.
//  Copyright © 2020 Anuranjan Bose. All rights reserved.
//

import Foundation

protocol DataController {
    var apiKey: String { get }
    func getURL() -> URL?
}

extension DataController {
    var apiKey: String {
        return "3853a66efa75400798dd1da0af19fe53"
    }
    
    func getURL() -> URL? {
        return URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")
    }
}
