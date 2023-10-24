//
//  SceneDelegate.swift
//  START-HW12-Arken
//
//  Created by Arken Sarsenov on 22.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
    }
}

