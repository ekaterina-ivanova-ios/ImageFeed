import UIKit

final class TabBarController: UITabBarController {

    override func awakeFromNib() {

        super.awakeFromNib()

        let storyboard = UIStoryboard(name: "Main", bundle: .main)

        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")

        let profileViewController = ProfileViewController()

        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil
        )
        
        profileViewController.tabBarItem.imageInsets = UIEdgeInsets(
            top: 5, left: 0,
            bottom: -5, right: 0
        )
        
        self.viewControllers = [imagesListViewController, profileViewController]
    }
    
} 
