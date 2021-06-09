//
//  NotificationsViewController.swift
//  Instagram.AniMekvabidze
//
//  Created by Mac User on 5/29/21.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       // tableView.
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // title = "Notifivations"
        
        view.backgroundColor = .systemBackground
       // tabbaritem.set
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)


    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }

}
