//
//  NewsFeedBuilder.swift
//  NewsFeed
//
//  Created by Nikita Entin on 12.06.2021.
//

import Foundation

final class NewsFeedVCBuilder {
  
    static func build() -> NewsFeedViewController {
        let interactor = NewsFeedInteractor()
        let router = NewsFeedRouter()
        let presenter = NewsFeedPresenter(interactor: interactor, router: router)
        let viewController = NewsFeedViewController(presenter: presenter)
        
        router.viewController = viewController
        presenter.view = viewController
        interactor.presenter = presenter
        
        return viewController
    }
}
