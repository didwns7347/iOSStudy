//
//  WebService.swift
//  MVVMPractice_GoodNews
//
//  Created by 최강훈 on 2021/03/28.
//

import Foundation
import Alamofire

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
    func getArticlesUsingAF(completion:@escaping([Article]?)->()){
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=e9b514c39c5f456db8ed4ecb693b0040"
        let result = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers:nil)
        result.responseJSON { response in
            switch response.result{
            case .success(let value):
                //print(value)
                do{
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let articleList = try JSONDecoder().decode(ArticleList.self, from: data)
                    completion(articleList.articles)
                    
                }catch{
                    completion(nil)
                }
                
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                completion(nil)
                break;
                
            }
        }
    }
}
