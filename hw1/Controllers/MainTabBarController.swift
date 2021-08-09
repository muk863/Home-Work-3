//
//  MainTabBarController.swift
//  hw1
//
//  Created by username on 27.06.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    func setupUser() -> [User] {
        var resultArray = [User]()
        
        let firstFotoArray = [UIImage(named: "cat1")!, UIImage(named: "cat2")!, UIImage(named: "cat3")!, UIImage(named: "cat4")!, UIImage(named: "cat5")!]
        let firstUser = User(name: "Cat", avatar: UIImage(named: "cat1")!, fotoArray: firstFotoArray)
        resultArray.append(firstUser)
        
        let secondFotoArray = [UIImage(named: "dog1")!, UIImage(named: "dog2")!, UIImage(named: "dog3")!, UIImage(named: "dog4")!, UIImage(named: "dog5")!]
        let secondUser = User(name: "Dog", avatar: UIImage(named: "dog1")!, fotoArray: secondFotoArray)
        resultArray.append(secondUser)
        
        return resultArray
    }
    
    func setupGroup() -> [Group] {
        var resultArray = [Group]()
        
        let firstGroup = Group(title: "Bears", avatar: UIImage(named: "bear1")!, description: "Bears")
        resultArray.append(firstGroup)
        
        let secondGroup = Group(title: "Raccoons", avatar: UIImage(named: "raccoon1")!, description: "Raccoons")
        resultArray.append(secondGroup)
        
        return resultArray
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        if let friendsNavigationController = self.viewControllers?.first as? UINavigationController,
           let friendsViewController = friendsNavigationController.viewControllers.first as? FriendsViewController {
            friendsViewController.configure(userArray: setupUser())
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

