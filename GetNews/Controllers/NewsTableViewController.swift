//
//  NewsTableViewController.swift
//  GetNews
//
//  Created by Anuranjan Bose on 13/06/20.
//  Copyright © 2020 Anuranjan Bose. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController, DataController {
    
    let disposeBag = DisposeBag()
    
    private var articles = [Article]()
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
    }
    
    private func populateNews() {
          
        /*
        guard let url = getURL() else {
            fatalError("URL is broken")
        }
        
        Observable.just(url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
        }.map { data -> [Article]? in
            return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
        }.subscribe(onNext: {[weak self] articles in
            if let articles = articles {
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
            }).disposed(by: disposeBag)
         */
                
        URLRequest.load(resource: ArticlesList.all)
            .subscribe(onNext: {[weak self] articleResponse in
                if let articleResponse = articleResponse {
                    //self?.articles = articleResponse.articles
                    let articles = articleResponse.articles
                    self?.articleListVM = ArticleListViewModel(articles)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: Datasource
extension NewsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.articles.count
        return self.articleListVM == nil ? 0 : self.articleListVM.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        
        /// Do this
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        /// OR, pass in the viewModel
        
        //cell.configureCell(with: articleVM)
        
        return cell
    }
}
