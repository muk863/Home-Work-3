
import UIKit
import RealmSwift

final class AllGroupViewController: UITableViewController {

    private let networkGroup = NetworkGroup()
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    private var itemsGroupRealm : Results<RealmGroup>!
    private var allGroup = [Group]()
    private let reuseIdentifareCellGroup = "reuseIdentifareCellGroup"

    func  setupGroup() -> [Group] {
        var itogArray = [Group]()
        itemsGroupRealm = realm.objects(RealmGroup.self)
        let countGroup = itemsGroupRealm.count

        for i in 0 ..< countGroup {
            let nameGroup = itemsGroupRealm[i].titleGroup
            let avaGroup = itemsGroupRealm[i].avaGroup
            let idGroup = itemsGroupRealm[i].idGroup
            let group = Group(idGroup: idGroup, titleGroup: nameGroup, avaGroup: avaGroup)
            itogArray.append(group)
        }
        itogArray = itogArray.sorted(by:{ $0.titleGroup < $1.titleGroup})
        return itogArray
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        allGroup = setupGroup()
        self.tableView.register(UINib(nibName: "UniversalTableViewCell", bundle: nil),
                                forCellReuseIdentifier: reuseIdentifareCellGroup)
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroup.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifareCellGroup, for: indexPath) as? UniversalTableViewCell else {return UITableViewCell()}
        cell.configureCell(group: allGroup[indexPath.row])
        return cell
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UniversalTableViewCell,
              let cellObject = cell.saveObject as? Group else {return}
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendGroup"), object: cellObject)
        self.navigationController?.popViewController(animated: true)
    }
}
