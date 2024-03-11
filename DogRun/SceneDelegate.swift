//
//  SceneDelegate.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/03.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
             
        // 탭 바 컨트롤러 생성
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.backgroundColor = .white

        // 첫 번째 뷰 컨트롤러 생성
        let mainView = MainViewController()
        mainView.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)

        // 두 번째 뷰 컨트롤러 생성
        let recordView = DogInfoViewController()
        recordView.tabBarItem = UITabBarItem(title: "Record", image: nil, selectedImage: nil)
        
        // 세 번째 뷰 컨트롤러 생성
        let settingView = UserInfoViewController()
        settingView.tabBarItem = UITabBarItem(title: "Setting", image: nil, selectedImage: nil)

        // 탭 바에 뷰 컨트롤러 추가
        tabBarController.viewControllers = [mainView, recordView, settingView]

        // 윈도우 설정

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

