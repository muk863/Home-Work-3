//
//  VKLoginViewController.swift
//  hw1
//
//  Created by username on 09.08.2021.
//

import UIKit
import WebKit

class TableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}

class VKLoginViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7922724"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131"),
        ]

        let request = URLRequest(url: urlComponents.url!)
         
        webView.load(request)
    }
    
}


extension VKLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
              let fragment = url.fragment  else {
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
     
        Session.dataSession.token = params["access_token"] ?? ""
        Session.dataSession.userID = params["user_id"] ?? ""
        
        print(Session.dataSession.token)
        print(Session.dataSession.userID)
        
        friendsRequest()
        photosRequest()
        groupsRequest()
        
        let vc = TableViewController()
        present(vc, animated: true)
        
        decisionHandler(.cancel)
    }
    
}

final class Session {
    
    var token: String = ""
    var userID: String = ""
    
    private init() {}
    
    static let dataSession = Session ()
}

//MARK: - netRequests

func friendsRequest() {

    guard let url = URL(string:"https://api.vk.com/method/friends.get?user_ids=\(Session.dataSession.userID)&fields=bdate&access_token=\(Session.dataSession.token)&v=5.131") else { return }

    let request = URLRequest(url: url)

    let dataTask = URLSession.shared.dataTask(with: request) {data, response, error in

        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
                print(error)
            }
        }
    }
    dataTask.resume()
}

func photosRequest() {

    guard let url = URL(string:"https://api.vk.com/method/photos.getAll?user_ids=\(Session.dataSession.userID)&fields=bdate&access_token=\(Session.dataSession.token)&v=5.131") else { return }

    let request = URLRequest(url: url)

    let dataTask = URLSession.shared.dataTask(with: request) {data, response, error in

        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
                print(error)
            }
        }
    }
    dataTask.resume()
}

func groupsRequest() {

    guard let url = URL(string:"https://api.vk.com/method/groups.get?user_id=\(Session.dataSession.userID)&extended=1&fields=bdate&access_token=\(Session.dataSession.token)&v=5.131") else { return }

    let request = URLRequest(url: url)

    let dataTask = URLSession.shared.dataTask(with: request) {data, response, error in

        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
                print(error)
            }
        }
    }
    dataTask.resume()
}





