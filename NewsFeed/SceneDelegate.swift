//
//  SceneDelegate.swift
//  NewsFeed
//
//  Created by Nikita Entin on 12.06.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let vc = NewsFeedVCBuilder.build()
        let rootNC = UINavigationController(rootViewController: vc)
        
        self.window?.rootViewController = rootNC
        self.window?.makeKeyAndVisible()
    }

}

