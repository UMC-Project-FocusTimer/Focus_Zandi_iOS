//
//  StaticViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/04.
//

import UIKit

class StaticViewController: UIViewController {

   
    @IBOutlet weak var staticTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
    }
    
    
    private func setTableView() {
        self.staticTableView.dataSource = self
        self.staticTableView.delegate = self
        staticTableView.separatorStyle = .none
        registerAllCell()
    }
    
    func registerAllCell() {
        staticTableView.register(UINib(nibName: "ZandiTableViewCell", bundle: .main), forCellReuseIdentifier: "ZandiTableViewCell")
        staticTableView.register(UINib(nibName: "ZandiTitleTableViewCell", bundle: .main), forCellReuseIdentifier: "ZandiTitleTableViewCell")
    }
}

extension StaticViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let zandiTitleCell = tableView.dequeueReusableCell(withIdentifier: "ZandiTitleTableViewCell", for: indexPath) as? ZandiTitleTableViewCell else { return UITableViewCell() }

            return zandiTitleCell
        case 1:
            guard let zandiCell = tableView.dequeueReusableCell(withIdentifier: "ZandiTableViewCell", for: indexPath) as? ZandiTableViewCell else { return UITableViewCell() }
            
            return zandiCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 50
        case 1:
            return 150
        default:
            return 0
        }
    }
}
