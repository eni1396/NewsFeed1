//
//  PostCell.swift
//  NewsFeed
//
//  Created by Nikita Entin on 13.06.2021.
//

import UIKit
import AVKit

class PostCell: UITableViewCell {
    
    static let reuseId = "PostCell"
    private lazy var videoPlayer = AVPlayer(playerItem: nil)
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5103616645, green: 0.6969909231, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let postView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let userImageView: CustomImageView = {
       let view = CustomImageView()
        view.image = UIImage(named: "user")
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let userDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let likesImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    let postViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let postViewImageView: CustomImageView = {
        let view = CustomImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var postViewVideoView: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: self.videoPlayer)
        layer.videoGravity = .resizeAspectFill
        return layer
    }()
    let postViewLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addFirstLayer()
        addSecondLayer()
        addLayerToHeaderView()
        addLayerToPostView()
        addlayerToBottomView()
        addLayerToPostViewContentView()
        addLayerToAllSubviewsOfBottomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postViewImageView.image = nil
        userImageView.image = nil
        videoPlayer = AVPlayer(playerItem: nil)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        postViewVideoView.frame = postViewContentView.layer.bounds
    }
    
    @objc func playVideo(url: URL) {
            let playerItem = AVPlayerItem(url: url)
            self.videoPlayer.replaceCurrentItem(with: playerItem)
            self.videoPlayer.volume = 0
            self.videoPlayer.play()
    }
    
    func addLayerToHeaderView() {
        [userImageView, userDateLabel, userNameLabel].forEach {
            headerView.addSubview($0)
        }
        
        // userImageView setup
        
        userImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        userImageView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
         //userDateLabel setup
        userDateLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 11).isActive = true
        userDateLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor).isActive = true
        userDateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        // userNameLabel setup
        userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
    }
    
    func addLayerToPostView() {
        postView.addSubview(postViewContentView)
        postView.addSubview(postViewLabel)
        
        // postViewContentView setup
        postViewContentView.leadingAnchor.constraint(equalTo: postView.leadingAnchor).isActive = true
        postViewContentView.trailingAnchor.constraint(equalTo: postView.trailingAnchor).isActive = true
        postViewContentView.bottomAnchor.constraint(equalTo: postView.bottomAnchor).isActive = true
        postViewContentView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        // postViewLabel setup
        postViewLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor,constant: 10).isActive = true
        postViewLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor).isActive = true
        postViewLabel.bottomAnchor.constraint(equalTo: postViewContentView.topAnchor,constant: -10).isActive = true
        postViewLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func addLayerToPostViewContentView() {
        // postViewContentView setup
        postViewContentView.addSubview(postViewImageView)
        postViewContentView.layer.addSublayer(postViewVideoView)
        
        postViewImageView.fillSuperview()
    }
    
    func addLayerToAllSubviewsOfBottomView() {
        
        // bottom view setup
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        addSubviewToBottomLayer(view: likesView, imageView: likesImage, label: likesLabel)
        addSubviewToBottomLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        addSubviewToBottomLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        addSubviewToBottomLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
    }
    
    private func addSubviewToBottomLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        
        // imageView constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        // label constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 7).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    func addlayerToBottomView() {
        [likesView, commentsView, sharesView, viewsView].forEach {
            bottomView.addSubview($0)
        }
        // likesView setup
        likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        likesView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        likesView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        likesView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // commentsView setup
        commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor).isActive = true
        commentsView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        commentsView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        commentsView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // sharesView setup
        sharesView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor).isActive = true
        sharesView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        sharesView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        sharesView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // viewsView setup
        viewsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        viewsView.leadingAnchor.constraint(equalTo: sharesView.trailingAnchor).isActive = true
        viewsView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        viewsView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
    }
    func addSecondLayer() {
        [headerView, postView, bottomView].forEach {
            mainView.addSubview($0)
        }
        // headerView setup
        headerView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8).isActive = true
        headerView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8).isActive = true
        headerView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        // postView setup
        postView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8).isActive = true
        postView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8).isActive = true
        postView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -1).isActive = true
        postView.heightAnchor.constraint(equalToConstant: 340).isActive = true
        
        // bottomView setup
        bottomView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func addFirstLayer() {
        addSubview(mainView)
        mainView.fillSuperview()
    }
}
