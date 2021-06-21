//
//  NewsFeedPresenter.swift
//  NewsFeed
//
//  Created by Nikita Entin on 12.06.2021.
//

import Foundation

protocol NewsFeedPresenterProtocol: AnyObject {
    var userInfo: [Item] { get set }
    var isPreloading: Bool { get set }
    var viewModel: CellViewModel? { get set }
    var currentCursor: String? { get set }
    
    func getData()
    func sendData()
    func sortByPopularity()
    func sortByCreation()
    func loadMoreData(cursor: String)
    func setupViewModel(at indexPath: IndexPath) -> CellViewModel
}

final class NewsFeedPresenter: NewsFeedPresenterProtocol {
    var userInfo = [Item]()
    var isPreloading = false
    var currentCursor: String? = nil
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    var viewModel: CellViewModel?
    weak var view: NewsFeedViewProtocol?
    
    private let interactor: NewsFeedInteractorProtocol
    private let router: NewsFeedRouterProtocol
    
    init(interactor: NewsFeedInteractorProtocol, router: NewsFeedRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func getData() {
        interactor.getUserInfo()
    }
    
    ///assigning data to cell model
    func setupViewModel(at indexPath: IndexPath) -> CellViewModel {
        let date: Date? = Date(timeIntervalSince1970: TimeInterval(userInfo[indexPath.row].createdAt))
        let userPath: String? = userInfo[indexPath.row].author?.photo?.data.extraSmall.url
        
        var videoURL = URL(string: "")
        var postImage: String? = ""
        if userInfo[indexPath.row].contents.count > 1 {
            if let contentPathImage = userInfo[indexPath.row].contents.last(where: { $0.type.rawValue == "IMAGE" || $0.type.rawValue == "IMAGE_GIF"}) {
                postImage = contentPathImage.data.small?.url
            }
            if let contentPathVideo = userInfo[indexPath.row].contents.last(where: { $0.type.rawValue == "VIDEO" }),
               let contentVideo = contentPathVideo.data.url {
                videoURL = URL(string: contentVideo)
            }
        }
        return CellViewModel(userImage: userPath,
                             postImage: postImage,
                             postVideo: videoURL,
                             name: userInfo[indexPath.row].author?.name,
                             date: dateFormatter.string(from: date ?? Date()),
                             text: userInfo[indexPath.row].contents.first?.data.value ?? "",
                             likes: userInfo[indexPath.row].stats.likes.count.description,
                             comments: userInfo[indexPath.row].stats.comments.count.description,
                             shares: userInfo[indexPath.row].stats.shares.count.description,
                             views: userInfo[indexPath.row].stats.views.count.description)
    }
    
    func loadMoreData(cursor: String) {
        interactor.getUserInfo(string: cursor, type: .after)
    }
    
    func sendData() {
        self.view?.receiveData()
    }
    
    func sortByPopularity() {
        interactor.getPopularInfo(string: nil, type: .mostPopular)
    }
    
    func sortByCreation() {
        interactor.getCreatedInfo(string: nil, type: .createdAt)
    }
}

