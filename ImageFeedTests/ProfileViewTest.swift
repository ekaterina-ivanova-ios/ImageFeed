@testable import ImageFeed

import XCTest

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    var getProfileCalled = false
    var updateAvatarCalled = false
    
    var view: ProfileViewControllerProtocol?
    
    func getProfile() -> Profile? {
        getProfileCalled = true
        return Profile()
    }
    
    func getUrlAvatar() -> URL? {
        updateAvatarCalled = true
        return URL(string: "testString")
    }
    
    func logout() {
        
    }
}

final class ProfileViewTest: XCTestCase {
    func testFetchProfileInfo() {
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()

        viewController.presenter = presenter
        presenter.view = viewController

        _ = viewController.view

        XCTAssertTrue(presenter.getProfileCalled)
    }

    func testFetchAvatarUrl() {
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()

        viewController.presenter = presenter
        presenter.view = viewController
        
        _ = viewController.view

        XCTAssertTrue(presenter.updateAvatarCalled)
    }
}
