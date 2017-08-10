//
//  ProfileViewController.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-26.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth 

class ProfileViewController: UIViewController {


    var polls = [Poll]()


    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        configureTableView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserService.polls { (polls) in
            self.polls = polls
            self.tableView.reloadData()
        }
    }

  
    func configureTableView() {
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        // remove separators from cells
        tableView.separatorStyle = .none
    }

 
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
    
        try! Firebase.Auth.auth().signOut()
        
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "first") as? FirstViewController
        self.show(vc!, sender: self)
        
        let userDefault = UserDefaults.standard
        userDefault.set(false, forKey: "loggedIn")
        userDefault.synchronize()
 }


    }
    


extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfilePollsCell", for: indexPath) as! ProfilePollsCell
        let poll = polls[indexPath.row]
        
        cell.delegate = self
        
        cell.profilePollText1.text = poll.content
        cell.profilePollText2.text = poll.content2
        cell.profilePollTitle.text = poll.title 
        
        poll.votePercent =
            (Double(poll.voteCount) / Double((poll.voteCount + poll.voteCount2)) * Double(100)).roundTo2(places: 2)
        poll.votePercent2 = (Double(poll.voteCount2) / Double((poll.voteCount + poll.voteCount2)) * Double(100)).roundTo2(places: 2)
        
        if poll.votePercent.isNaN {
            poll.votePercent = 0
        }
        
        if poll.votePercent2.isNaN {
            poll.votePercent2 = 0
        }
        
        if poll.votePercent.isInfinite {
            poll.votePercent = 0
        }
        
        if poll.votePercent2.isInfinite {
            poll.votePercent2 = 0
        }
        
        if poll.votePercent < 0 {
            poll.votePercent = 0
        }
        
        if poll.votePercent2 < 0 {
            poll.votePercent2 = 0
        }
        
        cell.profilePollText1Per.text = "\(String(format: "%.0f", poll.votePercent))%"
        cell.profilePollText2Per.text = "\(String(format: "%.0f", poll.votePercent2))%"
        return cell
    }
    
}

extension ProfileViewController: ProfilePollsCellDelegate {
    func didTapVoteButton(_profileTextButton: UIButton, pollNum: Int, on cell: ProfilePollsCell) {
        
        guard let indexPath = tableView.indexPath(for: cell)
            else { return }
        
        
        let poll = polls[indexPath.row]
        
  
        
        if pollNum == 1 {
            
            if poll.isVoted[User.current] == true {
                poll.voteCount -= 1
                poll.isVoted[User.current] = false
                
            }
                
            else {
                poll.voteCount += 1
                poll.isVoted[User.current] = true
                
                if poll.isVoted2[User.current] == true {
                    poll.voteCount2 -= 1
                    poll.isVoted2[User.current] = false
                }
            }
            
            
        }
            
        else if pollNum == 2 {
            
            
            
            if poll.isVoted2[User.current] == true {
                poll.voteCount2 -= 1
                poll.isVoted2[User.current] = false
            }
                
            else {
                poll.voteCount2 += 1
                poll.isVoted2[User.current] = true
                
                if poll.isVoted[User.current] == true {
                    poll.voteCount -= 1
                    poll.isVoted[User.current] = false
                }
            }
            
        }
        

    }
    
}

extension Double {
    func roundTo2(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
        
    }
}


extension ProfileViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "add") as! AddPollViewController
            
            self.present(vc, animated: true, completion: nil)
            
            return false
        }
        return true
    }
}



