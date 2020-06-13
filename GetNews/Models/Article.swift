//
//  Article.swift
//  GetNews
//
//  Created by Anuranjan Bose on 14/06/20.
//  Copyright © 2020 Anuranjan Bose. All rights reserved.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

extension ArticlesList: DataController {
    static var all: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=3853a66efa75400798dd1da0af19fe53")!
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    let title: String
    let description: String
    
}
