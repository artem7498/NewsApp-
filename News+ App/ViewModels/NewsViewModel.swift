//
//  NewsViewModel.swift
//  News+ App
//
//  Created by Артём on 6/1/21.
//

import Foundation

struct NewsViewModel {
    
    let news: News
    
    var author: String {
        return news.author ?? "Unknown"
    }
    
    var title: String {
        return news.title ?? ""
    }
    
    var description: String {
        return news.description ?? ""
    }
    
    var url: String {
        return news.url ?? ""
    }
    
    var urlToImage: String {
        return news.urlToImage ?? "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png"
    }
    
}
