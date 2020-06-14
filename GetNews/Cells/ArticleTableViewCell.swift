//
//  ArticleTableViewCell.swift
//  GetNews
//
//  Created by Anuranjan Bose on 14/06/20.
//  Copyright © 2020 Anuranjan Bose. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    func configureCell(with articleVM: ArticleViewModel) {
        //self.titleLabel.text = articleVM.title.
        
        articleVM.description.subscribe(onNext: {[weak self] description in
            self?.descriptionLabel.text = description
            }).disposed(by: disposeBag)
        
        articleVM.title.subscribe(onNext: {[weak self] title in
            self?.titleLabel.text = title
            }).disposed(by: disposeBag)
    }
}

