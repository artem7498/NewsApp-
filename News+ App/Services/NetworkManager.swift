//
//  NetworkManager.swift
//  News+ App
//
//  Created by Артём on 6/1/21.
//

import Foundation

class NetworkManager {
    
    let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURLString = "https://newsapi.org/v2/"
    private let USTopHeadline = "top-headlines?country=us"
    private let wallStreetAll = "everything?domains=wsj.com"
    
//    https://newsapi.org/v2/top-headlines?country=us&apiKey=6a4cd2f2329c4a7ba4853dddad565ade
    
    func getNews(completion: @escaping ([News]?) -> Void){
        let urlString = "\(baseURLString)\(USTopHeadline)&apiKey=\(ApiKey.key)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
//              self.handleClientError(error)
                print("error: \(String(describing: error))")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let codeResponse = response as! HTTPURLResponse
                print("Status Code:", codeResponse.statusCode)
//                self.handleServerError(response)
                return
            }
            
            guard let mime = httpResponse.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                let newsEnvelop = try JSONDecoder().decode(NewsEnvelop.self, from: data!)
                completion(newsEnvelop.articles)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)){
            completion(cachedImage as Data)
        } else {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil || data == nil {
    //              self.handleClientError(error)
                    print("error ImageCacher: \(String(describing: error))")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    let codeResponse = response as! HTTPURLResponse
                    print("Status Code ImageCacher:", codeResponse.statusCode)
    //                self.handleServerError(response)
                    return
                }
                
//                guard let mime = httpResponse.mimeType, mime == "application/json" else {
//                    print("Wrong MIME type!")
//                    return
//                }
                
                self.imageCache.setObject(data! as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
}
