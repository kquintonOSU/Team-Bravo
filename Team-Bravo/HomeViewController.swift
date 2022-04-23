//
//  HomeViewController.swift
//  Team-Bravo
//
//  Created by Kolton Quinton on 3/8/22.
//

import UIKit
import SideMenu
import Firebase

class HomeViewController: UIViewController, MenuViewControllerDelegate {
//    let user = Auth.auth().currentUser?.displayName
    
    private var showSideMenu: SideMenuNavigationController?

    var firebaseUserID = ""
    var email_ = ""
    var firstName = ""
    var lastName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let ListMenu = MenuViewController(with: ["Profile", "About"])
        ListMenu.delegate = self
        showSideMenu = SideMenuNavigationController(rootViewController: ListMenu)

        showSideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = showSideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)

        welcomeLabel.text = "Welcome to Reserva"
        print("======== FirebaseID: ", firebaseUserID)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedMenuBarButton(){
        present(showSideMenu!, animated: true)
    }
    
    func transitionToSellers() {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.CreateEventVC) as? CreateEventVC
        vc?.firebaseUserID = firebaseUserID
        print("Transitioning to seller: ", vc)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func transitionToBuyers() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.ViewEventsViewController) as? ViewEventsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        //transition to event table view controller of a list of all events in the database.
        //tapping on an event on the table view will show the corresponding event details.
        //this is the last thing to complete to have a "functioning" app.
        //once we complete this, we can add styling and some things prof mentioned.
    }
    
    @IBOutlet weak var myEvents: UIButton!
    @IBOutlet weak var buyers: UIButton!
    @IBOutlet weak var sellers: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    @IBAction func didSellersSelected(_ sender: Any) {
        transitionToSellers()
    }

    @IBAction func didBuyersSelected(_ sender: Any) {
        transitionToBuyers()
    }
    
    @IBAction func didMyEventsSelected(_ sender: Any) {
        //transitionToMyEvents
        //statistics for logged in users posted events
        //we are almost done
    }
    
    func transitionToProfile() {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.profileVC) as? ProfileViewController
            //vc?.firebaseUserID = firebaseUserID
        vc?.email_ = email_
        vc?.firstName_ = firstName
        vc?.LastName_ = lastName

        print("Transitioning to Profile: ", vc)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func transitionToAbout() {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.aboutVC) as? AboutViewController
            //vc?.firebaseUserID = firebaseUserID
        print("Transitioning to About: ", vc)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tappedMenuItem(controllerItem: String) {
        if controllerItem == "Profile"{
            print("========= Profile ========")
            showSideMenu?.dismiss(animated: true)
            transitionToProfile()
        }else{
            print("========= Others ========")
            showSideMenu?.dismiss(animated: true)
            transitionToAbout()
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

protocol MenuViewControllerDelegate{
    func tappedMenuItem(controllerItem: String)
}



class MenuViewController: UITableViewController{
    private let itemInMenu : [String]
    
    public var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .darkGray
        view.backgroundColor = .darkGray
    }
    
    
    init(with items: [String]) {
        self.itemInMenu = items
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error in loading init")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemInMenu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemInMenu[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.contentView.backgroundColor = .lightGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tappedItemNow = itemInMenu[indexPath.row]
        delegate?.tappedMenuItem(controllerItem: tappedItemNow)
    }
    
    func transitionToProfile() {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.profileVC) as? ProfileViewController
            //vc?.firebaseUserID = firebaseUserID
        print("Transitioning to Profile: ", vc)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
