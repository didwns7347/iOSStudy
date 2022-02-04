//
//  WebService.swift
//  MVVMPractice_GoodNews
//
//  Created by 최강훈 on 2021/03/28.
//

import Foundation

class WebService {
    private let url = URL(string :"https://newsapi.org/v2/top-headlines?country=us&apiKey=e9b514c39c5f456db8ed4ecb693b0040")!
    func getArticles( completion: @escaping ([Article]?) -> ()) {
        URLSession.shared.dataTask(with: self.url) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil) // if any error occurs, article can be nil
            }
            else if let data = data {
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                print(articleList)
                if let articleList = articleList {
                    completion(articleList.articles)
                }
                print(articleList?.articles)
                 
            }
            
        }.resume()
        
    }
}
