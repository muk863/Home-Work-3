//
//  LoginViewController.swift
//  hw1
//
//  Created by username on 12.06.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var loadingView1: UIImageView!
    @IBOutlet weak var loadingView2: UIImageView!
    @IBOutlet weak var loadingView3: UIImageView!
    
    let toTabBarSegueIdentifier = "fromLoginToTabBar"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView1.alpha = 0
        loadingView2.alpha = 0
        loadingView3.alpha = 0
        
        animateLoginPasswordLabel()
        animateTextField()
        animateLoginButton()
        animateLoading()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDie))
        backView.addGestureRecognizer(gestureRecognizer)
        
        loginButton.layer.cornerRadius = 15
    }
    
    @objc func keyboardDie() {
        self.scrollView.endEditing(true)
    }
    
    @objc func keyboardWasShown() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 250, right: 0)
    }

    @objc func keyboardHide() {
        scrollView.contentInset = UIEdgeInsets.zero
    }
        
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showAlert(message: String, complection: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: complection)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func animateLoginPasswordLabel() {
        loginLabel.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        passwordLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        
        UIView.animate(withDuration: 2,
                       delay: 1,
                       options: .curveEaseInOut,
                       animations: {
                        self.loginLabel.transform = .identity
                        self.passwordLabel.transform = .identity
                       },
                       completion: nil)
    }
    
    func animateTextField() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        loginTextField.layer.add(animation, forKey: nil)
        passwordTextField.layer.add(animation, forKey: nil)
        
    }
    
    func animateLoginButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards

        self.loginButton.layer.add(animation, forKey: nil)
    }
    
    func animateLoading() {
        UIView.animateKeyframes(withDuration: 1,
                                delay: 0,
                                options: [.autoreverse, .repeat],
                                animations: { [weak self] in
                                    self?.loadingView1.alpha = 1
                                },
                                completion: nil)
        UIView.animateKeyframes(withDuration: 1,
                                delay: 0.5,
                                options: [.autoreverse, .repeat],
                                animations: { [weak self] in
                                    self?.loadingView2.alpha = 1
                                },
                                completion: nil)
        UIView.animateKeyframes(withDuration: 1,
                                delay: 1,
                                options: [.autoreverse, .repeat],
                                animations: { [weak self] in
                                    self?.loadingView3.alpha = 1
                                },
                                completion: nil)
        return
    }

    @IBAction func pressLoginButton(_ sender: Any) {
        if let login = loginTextField.text,
           let password = passwordTextField.text,
            login == "1",
            password == "1" {
            self.loginButton.backgroundColor = UIColor.systemTeal
            //self.backView.backgroundColor = UIColor.white
            
            performSegue(withIdentifier: toTabBarSegueIdentifier, sender: nil)
                        
        }
        else {
            showAlert(message: "Error login or password") { [weak self] _ in
                self?.loginButton.backgroundColor = UIColor.red
                self?.animateLoginButton()
                //self.backView.backgroundColor = UIColor.blue
            }
        }
    }
}
