//
//  sideMenuViewController.swift
//  SideMenu
//
//  Created by Rajat on 7/3/17.
//  Copyright © 2017 Rajat. All rights reserved.
//

import UIKit
protocol slideDelegate {
    func MenuSelected(index : Int)
}
class sideMenuViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {
   
    
     var menuTitleNames = NSMutableArray()
    
    
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    var delegate : slideDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "sideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "sideMenuTableViewCell")
        self.tableView.separatorStyle = .none
        //self.tableView.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuTableViewCell")! as! sideMenuTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.MenuTitle.text = menuTitleNames.object(at: indexPath.row) as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuTitleNames.count
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.delegate.MenuSelected(index: indexPath.row)
    }

    

}
