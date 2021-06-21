//
//  DetailViewController.swift
//  NewsFeed
//
//  Created by Nikita Entin on 17.06.2021.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {
    
    lazy var videoPlayer = AVPlayer(playerItem: nil)
    let imageView: CustomImageView = {
        let view = CustomImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let videoView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var playerView: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: self.videoPlayer)
        layer.videoGravity = .resizeAspectFill
        return layer
    }()
    let label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5103616645, green: 0.6969909231, blue: 1, alpha: 1)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupView()
    }
    
    func playVideo(url: URL) {
            let playerItem = AVPlayerItem(url: url)
            self.videoPlayer.replaceCurrentItem(with: playerItem)
            self.videoPlayer.volume = 0
            self.videoPlayer.play()
    }
    private func setupView() {
        [imageView, label, videoView].forEach {
            view.addSubview($0)
        }
        videoView.layer.addSublayer(playerView)
        

        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        videoView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        videoView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
    }

}
