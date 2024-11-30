//
//  TabBarController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 29.11.24.
//

import UIKit

enum PageTitles: String {
    case home = "Home"
    case leaderBoard = "Leaderboard"
    case profile = "Profile"
}

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        
        let homePage = createTab(icon: AppAssets.Icons.home, vc: HomePageViewController(), identifier: HomePageViewController.reuseIdentifier, title: PageTitles.home.rawValue )
        let leaderBoardPage = createTab(icon: AppAssets.Icons.award, vc: LeaderBoardViewController(), identifier: LeaderBoardViewController.reuseIdentifier, title: PageTitles.leaderBoard.rawValue)
        let profilePage = createTab(icon: AppAssets.Icons.user, vc: ProfilePageViewController(), identifier: ProfilePageViewController.reuseIdentifier, title: PageTitles.profile.rawValue)
        
        customizeTabBarAppearance()
        
        let homePageNavController = UINavigationController(rootViewController: homePage)
        let leaderBoardPageNavController = UINavigationController(rootViewController: leaderBoardPage)
        let profilePageNavController = UINavigationController(rootViewController: profilePage)
        
        setViewControllers([homePageNavController, leaderBoardPageNavController, profilePageNavController], animated: true)
    }
    
    private func createTab(icon: String, vc: UIViewController, identifier: String, title: String) -> UIViewController {
        let iconImage = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
        
        let tabBarItem = UITabBarItem(title: title, image: iconImage, selectedImage: iconImage)
        tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -3, right: 0)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 3)
        tabBarItem.accessibilityIdentifier = identifier
        vc.tabBarItem = tabBarItem
        
        return vc
    }
    
    
    
    private func customizeTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(named: AppAssets.Colors.tabBackground)
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: AppAssets.Colors.tagText)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(named: AppAssets.Colors.tagText) ?? .black,
            .font: UIFont(name: MyFonts.interRegular.rawValue, size: 15) ?? .systemFont(ofSize: 15)
        ]
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: AppAssets.Colors.loginText)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(named: AppAssets.Colors.loginText) ?? .gray,
            .font: UIFont(name: MyFonts.interRegular.rawValue, size: 12) ?? .systemFont(ofSize: 12)
        ]
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        tabBar.layer.cornerRadius = 27
        tabBar.layer.masksToBounds = true
        tabBar.clipsToBounds = true
    }
}

