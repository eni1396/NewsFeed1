//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Nikita Entin on 12.06.2021.
//

import UIKit
import AVKit

protocol NewsFeedViewProtocol: AnyObject {
    
    func getUserData()
    func receiveData()
}

final class NewsFeedViewController: UIViewController, NewsFeedViewProtocol {
    var isReadyToLoad = false
    private lazy var popularitySortButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.image = UIImage(systemName: Constants.sortByPopularity)
        button.target = self
        button.action = #selector(sortByPopularity)
        return button
    }()
    private lazy var creationSortButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.target = self
        button.image = UIImage(systemName: Constants.sortByCreation)
        button.action = #selector(sortByCreation)
        return button
    }()
    
    private let presenter: NewsFeedPresenterProtocol
    private let table: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseId)
        return table
    }()
    
    init(presenter: NewsFeedPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUserData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.separatorStyle = .singleLine
    }
    
    private func createSpinnerView() -> UIView {
        let footerView = UIView(frame: .init(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func getUserData() {
        presenter.getData()
    }
    
    func receiveData() {
        isReadyToLoad = true
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    private func setupView() {
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
        table.fillSuperview()
        navigationItem.title = Constants.navTitle
        navigationItem.rightBarButtonItems = [popularitySortButton, creationSortButton]
        
    }
    
    @objc private func sortByCreation() {
        DispatchQueue.global().async {
            self.presenter.viewModel = nil
            self.presenter.sortByCreation()
        }
    }
    
    @objc private func sortByPopularity() {
        DispatchQueue.global().async {
            self.presenter.viewModel = nil
            self.presenter.sortByPopularity()
        }
    }
    
    
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.userInfo.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        DispatchQueue.global().async {
            self.presenter.viewModel = self.presenter.setupViewModel(at: indexPath)
            DispatchQueue.main.async {
                vc.label.text = self.presenter.viewModel?.text
                vc.imageView.downloadImageFrom(withUrl: self.presenter.viewModel?.postImage ?? "")
                vc.playVideo(url: self.presenter.viewModel?.postVideo ?? URL(fileURLWithPath: ""))
                self.navigationController?.pushViewController(vc, animated: true)
                self.table.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: PostCell.reuseId, for: indexPath) as! PostCell
        
        DispatchQueue.global(qos: .userInteractive).async {
            let viewModel = self.presenter.setupViewModel(at: indexPath)
            DispatchQueue.main.async {
                cell.userNameLabel.text = viewModel.name
                cell.postViewLabel.text = viewModel.text
                cell.viewsLabel.text = viewModel.views
                cell.likesLabel.text = viewModel.likes
                cell.sharesLabel.text = viewModel.shares
                cell.commentsLabel.text = viewModel.comments
                cell.userDateLabel.text = viewModel.date
                
                if let userImage = viewModel.userImage {
                    cell.userImageView.downloadImageFrom(withUrl: userImage)
                } else {
                    cell.userImageView.image = UIImage(named: "no_user")
                }
                if let postImage = viewModel.postImage {
                    cell.postViewImageView.downloadImageFrom(withUrl: postImage)
                }
                if let postVideo = viewModel.postVideo {
                    cell.playVideo(url: postVideo)
                }
            }
        }
        return cell
    }
}

extension NewsFeedViewController: UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let positionForPagination = scrollView.contentOffset.y
        if scrollView.contentSize.height - positionForPagination - scrollView.frame.height < 100 {
            isReadyToLoad = true
            table.tableFooterView = createSpinnerView()
            guard let cursor = presenter.currentCursor else {
                self.presenter.isPreloading = false
                return
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                if self.isReadyToLoad {
                    self.presenter.loadMoreData(cursor: cursor)
                    self.isReadyToLoad = false
                }
            }
            if self.presenter.isPreloading {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.table.reloadData()
                    self.table.tableFooterView = nil
                    self.presenter.isPreloading = false
                }
            }
        }
    }
}

