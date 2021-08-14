//
//  FriendsViewController.swift
//  hw1
//
//  Created by username on 27.06.2021.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let reuseIdentifierUniversalTableCell = "reuseIdentifierUniversalTableCell"
    let segueToFotoController = "fromFriendsToFoto"
        
    var friendsArray = [User]()
    var searchFriendsArray = [User]()
    
    var searchFlag = false
    
    func configure(userArray: [User]) {
        self.friendsArray = userArray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.tableView.register(UINib(nibName: "UniversalTableCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    func myFriendsArray() -> [User] {
        if searchFlag {
            return searchFriendsArray
        }
        return friendsArray
    }
    
    func arrayLetter() -> [String] {
        var resultArray = [String]()
        
        for item in myFriendsArray() {
            let nameLetter = String(item.name.prefix(1))
            if !resultArray.contains(nameLetter) {
                resultArray.append(nameLetter)
            }
        }
        return resultArray
    }

    func arrayByLetter(letter: String) -> [User] {
        var resultArray = [User]()
        
        for item in myFriendsArray() {
            let nameLetter = String(item.name.prefix(1))
            if nameLetter == letter {
                resultArray.append(item)
            }
        }
        return resultArray
    }
}

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchFlag = false
        }
        else {
            searchFlag = true
            searchFriendsArray = friendsArray.filter({ item in
                item.name.lowercased().contains(searchText.lowercased())
            })
        }
        tableView.reloadData()
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetter().count
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(letter: arrayLetter()[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableCell, for: indexPath) as? UniversalTableCell else {return UITableViewCell()}
        
        let arrayByLetterItems = arrayByLetter(letter: arrayLetter()[indexPath.section])
        cell.configure(user: arrayByLetterItems[indexPath.row])
        
        return cell
       
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToFotoController,
            let dst = segue.destination as? FotoController,
            let user = sender as? User {
            dst.fotoArray = user.fotoArray
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayLetter()[section].uppercased()
    }
    
    func tableView(_ tabView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UniversalTableCell,
              let cellObject = cell.saveObject as? User
        else {return}

        performSegue(withIdentifier: segueToFotoController, sender: cellObject)
    }
}
