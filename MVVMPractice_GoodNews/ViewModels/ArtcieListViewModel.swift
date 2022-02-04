//
//  ArtcieViewModel.swift
//  MVVMPractice_GoodNews
//
//  Created by 최강훈 on 2021/03/28.
//  수정 by 양준수 on 2022/02/04
//

import Foundation

class ArticleListViewModel {
    var articles: [Article] = [Article]()
    
    init(_ callback:@escaping(Bool) -> ()){
        WebService().getArticlesUsingAF{ (articles) in
            if let articles = articles {
                self.articles = articles
                callback(true)
            }
            else{
                self.articles = [Article]()
                callback(false)
            }
        }
    }
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}

class ArticleViewModel {
    private let article: Article
    init(_ article: Article) {
        self.article = article
    }
}



extension ArticleViewModel {
    var title: String? {
        return self.article.title
    }
    var description: String? {
        return self.article.description
    }
}
