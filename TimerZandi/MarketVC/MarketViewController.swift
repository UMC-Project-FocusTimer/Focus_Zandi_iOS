//
//  MarketViewController.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/21.
//

import UIKit

class MarketViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        //tableView.register(themeTableViewCell.self, forCellReuseIdentifier: themeTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "스토어"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
        setTableViewAutoLayout()
    }

    
    func setTableViewAutoLayout() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "AdTableViewCell", bundle: nil), forCellReuseIdentifier: "AdTableViewCell")
        tableView.register(UINib(nibName: "Market1TableViewCell", bundle: nil), forCellReuseIdentifier: "Market1TableViewCell")
    }
    
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as? AdTableViewCell else { return UITableViewCell() }
            print(type(of: cell))
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Market1TableViewCell", for: indexPath) as? Market1TableViewCell else { return UITableViewCell() }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
        default:
            return 250
        }
    }
}
