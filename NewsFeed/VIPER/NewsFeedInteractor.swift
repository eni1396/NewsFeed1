//
//  NewsFeedInteractor.swift
//  NewsFeed
//
//  Created by Nikita Entin on 12.06.2021.
//

import Foundation


protocol NewsFeedInteractorProtocol {
    
    func getUserInfo()
    func getUserInfo(string: String?, type: ApiManager.RequestType?)
    func getCreatedInfo(string: String?, type: ApiManager.RequestType?)
    func getPopularInfo(string: String?, type: ApiManager.RequestType?)
}

final class NewsFeedInteractor: NewsFeedInteractorProtocol {
    
    
    weak var presenter: NewsFeedPresenterProtocol?
    private let apiManager: ApiManager
    
    
    init(apiManager: ApiManager = ApiManager()) {
        self.apiManager = apiManager
    }
    
    ///default call
    func getUserInfo() {
        apiManager.fetch(string: nil, type: nil) { [weak self] (result: ViewModel) in
            guard let self = self,
                  let data = result.data else { return }
            self.presenter?.userInfo = data.items
            self.presenter?.currentCursor = data.cursor
            self.presenter?.sendData()
        }
    }
    ///fetch more data
    func getUserInfo(string: String?, type: ApiManager.RequestType?) {
        apiManager.fetch(string: string, type: .after) { [weak self] (result: ViewModel) in
            guard let self = self,
                  let data = result.data?.items else { return }
            self.presenter?.userInfo += data
            self.presenter?.currentCursor = result.data?.cursor
            self.presenter?.isPreloading = true
        }
    }
    
    ///fetch sort by popularity
    func getPopularInfo(string: String?, type: ApiManager.RequestType?) {
        apiManager.fetch(string: string, type: .mostPopular) { [weak self] (result: ViewModel) in
            guard let self = self,
                  let data = result.data?.items else { return }
            self.presenter?.userInfo = data
            self.presenter?.currentCursor = result.data?.cursor
            self.presenter?.sendData()
            self.presenter?.isPreloading = true
        }
    }
    ///fetch sort by creation date
    func getCreatedInfo(string: String?, type: ApiManager.RequestType?) {
        apiManager.fetch(string: string, type: .createdAt) { [weak self] (result: ViewModel) in
            guard let self = self,
                  let data = result.data?.items else { return }
            self.presenter?.userInfo = data

            self.presenter?.currentCursor = result.data?.cursor
            self.presenter?.sendData()
            self.presenter?.isPreloading = true
        }
    }
}
