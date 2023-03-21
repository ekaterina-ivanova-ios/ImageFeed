
import Foundation

public protocol WebViewPresenterProtocol {
    func viewDidLoad()
    func didUpdateProgressValue(_ newValue: Double)
    func code(from url: URL) -> String?
}

final class WebViewPresenter: WebViewPresenterProtocol {
    //MARK: - Properties
    weak var view: WebViewViewControllerProtocol?
    private let helper: AuthHelperProtocol
    private let authConfiguration = AuthConfiguration.standard
    
    //MARK: - LifeCycle
    init(helper: AuthHelperProtocol) {
        self.helper = helper
    }
    
    //MARK: - Functions
    func viewDidLoad() {
        guard let request = helper.authRequest() else { return }
        view?.load(request: request)
        didUpdateProgressValue(0)
    }
    
    func didUpdateProgressValue(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        view?.setProgressValue(newProgressValue)
        
        let shouldHideProgress = shouldHideProgress(for: newProgressValue)
        view?.setProgressHidden(shouldHideProgress)
    }
    
    func shouldHideProgress(for value: Float) -> Bool {
        abs(value - 1.0) <= 0.0001
    }
    
    func code(from url: URL) -> String? {
        helper.code(from: url)
    }
}
