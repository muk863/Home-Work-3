
import Foundation
import WebKit
import RealmSwift

final class LoginController: UIViewController{

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let realm = try? Realm() else {return}
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [URLQueryItem(name: "client_id", value: "7932879"),
                                 URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                 URLQueryItem(name: "display", value: "mobile"),
                                 URLQueryItem(name: "scope", value: "262150"),
                                 URLQueryItem(name: "response_type", value: "token"),
                                 URLQueryItem(name: "v", value: "5.131")]
        let url = components.url!
        let request = URLRequest(url: url)
        webView.load(request)
        remuove(realmUrl: realm.configuration.fileURL!)
    }

    func remuove(realmUrl : URL){

        let realmUrls = [
            realmUrl,
            realmUrl.appendingPathExtension("lock"),
            realmUrl.appendingPathExtension("note"),
            realmUrl.appendingPathExtension("management"),
        ]
        
        for URL in realmUrls {
            guard ((try? FileManager.default.removeItem(at: URL)) != nil) else {return}
        }
        
        guard let url = Realm.Configuration.defaultConfiguration.fileURL else {return}
        remuove(realmUrl: url)
    }
}

extension LoginController : WKNavigationDelegate {

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard navigationResponse.response.url?.path == "/blank.html",
              let fragment = navigationResponse.response.url?.fragment else {
            decisionHandler(.allow)
            return
        }
            
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
            
        Session.shared.token = params["access_token"] ?? ""
        Session.shared.userId = params["user_id"] ?? ""
        print("Token: " + Session.shared.token)
        print("User Id: " + Session.shared.userId)

        guard let vc = storyboard?.instantiateViewController(identifier: "TabBar") as? MyTabBarController else { return}
        present(vc, animated: true, completion: nil)
        decisionHandler(.cancel)
    }
}
