//
//  FollowingViewController.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/01.
//

import UIKit

var followingList: [String] = ["Song", "Onve", "Jason", "Yk"]
var followerTime = ["00:03:30", "02:34:33", "07:55:34", "00:40:23"]
var disturbCount = [3, 5, 6, 3]

var follwerDataModel = FollwerDataModel ()

class FollowingViewController: UIViewController {
    
//    let followerTableView: UITableView = {
//        let tableView = UITableView()
//        return tableView
//    }()
    
    @IBAction func addFollwer(_ sender: Any) {
        let alert = UIAlertController(title: "팔로워 등록", message: "같이 공부할 친구 추가하기", preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let follwee_Name = alert.textFields?[0].text else {return}
            addFollwerPost(accessToken: accessToken, refToken: refToken, follweeName: follwee_Name)
            
        })
        let cancleButton = UIAlertAction(title: "취소", style: .default, handler:nil)
        alert.addAction(cancleButton)
        alert.addAction(registerButton)
        alert.addTextField(configurationHandler: {
            textField in textField.placeholder = "친구의 이름을 알려주세요"
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var follwerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        follwerTableView.dataSource = self
        follwerTableView.delegate = self
//        followerTableViewAutoLayout()
        follwerTableView.register(UINib(nibName: "FollowerTableViewCell", bundle: .main), forCellReuseIdentifier: "FollowerTableViewCell")
        follwerTableView.allowsSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var THEME_KEY = UserDefaults.standard.integer(forKey: "THEME_KEY")

        super.viewWillAppear(animated)
        
        if THEME_KEY != 0 {
        let textAttributes = [NSAttributedString.Key.foregroundColor:themes[THEME_KEY][0]]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else {
            let textAttributes = [NSAttributedString.Key.foregroundColor:themes[8][0]]
            navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }

    
    @IBAction func pushPlusButton(_ sender: Any) {
        print("add new Follower")
    }
    
    
    @IBAction func pushReloadButton(_ sender: Any) {
        print("reload")
        follwerTableView.reloadData()
    }

}

//extension FollowingViewController {
//    func followerTableViewAutoLayout() {
//        self.view.addSubview(followerTableView)
//        followerTableView.translatesAutoresizingMaskIntoConstraints = false
//
//        followerTableView.separatorInset.left = 0
//
//        followerTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        followerTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        followerTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        followerTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//    }
//}

extension FollowingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        UserDefaults.standard.setValue(indexPath.row, forKey: "SELECTED")

        guard let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "FollwersPageViewController") as? FollwersPageViewController else {return}
            self.navigationController?.pushViewController(ViewController, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follwerDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTableViewCell", for: indexPath) as? FollowerTableViewCell else { return UITableViewCell() }
        
        let followerName = follwerDataModel.getFolloweName(index: indexPath.row)
        let brokenCount = follwerDataModel.getBrokenCount(index: indexPath.row)
        let todayFocusTime = follwerDataModel.getTodayFocusTime(index: indexPath.row)
        let image = follwerDataModel.getImage(index: indexPath.row)
        
        cell.follwerImage.image = UIImage(named: image)
        cell.userNameLabel.text = followerName
//        cell.disturbCountLabel.text = String(brokenCount) + "초"
//        cell.totalTimeLabel.text = String(todayFocusTime) + "회"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
          
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            followingList.remove(at: indexPath.row)
            followerTime.remove(at: indexPath.row)
            disturbCount.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()

        } // model에 remove함수 만들어서 가져오기 
    }
    
}
// 선택되면 페이지 넘어가고 넘어간 페이지에서 데이터 가져오기
