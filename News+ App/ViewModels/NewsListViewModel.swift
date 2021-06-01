//
//  NewsListViewModel.swift
//  News+ App
//
//  Created by Артём on 6/1/21.
//

import Foundation

class NewsListViewModel {
    
    var newsVM = [NewsViewModel]()
    
    var reuseID = "news"
    
    func getNews(completion: @escaping ([NewsViewModel]) -> Void){
        NetworkManager.shared.getNews { news in
            guard let news = news else {return}
            let newsVM = news.map(NewsViewModel.init)
            DispatchQueue.main.async {
                self.newsVM = newsVM
                completion(newsVM)
            }
        }
    }
}
