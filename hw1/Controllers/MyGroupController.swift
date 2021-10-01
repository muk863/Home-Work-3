
import UIKit
import RealmSwift



final class MyGroupController: UITableViewController {

    public var selectedGroupsId = [String]()
    private let networkNews = NetworkNews()
    private var myGroup = [Group]()
    private let reuseIdentifareCellGroup = "reuseIdentifareCellGroup"
    private var newsRealm : Results<RealmNews>!

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "UniversalTableViewCell", bundle: nil),
                                      forCellReuseIdentifier: reuseIdentifareCellGroup)

        NotificationCenter.default.addObserver(self, selector: #selector(addNewGroup(_:)),
                                               name: NSNotification.Name(rawValue: "sendGroup"),
                                               object: nil)
        navigationItem.title = "Избранные группы"
    }

    func isConteinInArray (group : Group) -> Bool {
        if myGroup.contains(where: { itemGroup in itemGroup.titleGroup == group.titleGroup}) {
            return true
        }
        return false
    }

    @objc func addNewGroup (_ notification : Notification) {
        guard let newGroup = notification.object as? Group else {return}
        if isConteinInArray(group: newGroup) {
            return
        }
        
        myGroup.append(newGroup)
        selectedGroupsId.append(newGroup.idGroup)
        networkNews.pingMyNews(idGroup: newGroup.idGroup)
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath){

        myGroup.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .top)
        selectedGroupsId.remove(at: indexPath.row)
        networkNews.deleteMyNewsToRealm(remainingGroupsId: selectedGroupsId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroup.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifareCellGroup,
                                                       for: indexPath) as? UniversalTableViewCell
                                                        else {return UITableViewCell()}
        cell.configureCell(group: myGroup[indexPath.row])
        //animateGroupController()
        cell.animateAvatar()
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
}
