//
//  News.swift
//  News+ App
//
//  Created by Артём on 6/1/21.
//

import Foundation

struct News: Decodable {
    
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
    
    
}

struct NewsEnvelop: Decodable{
    let status: String
    let totalResults: Int
    let articles: [News]
}
