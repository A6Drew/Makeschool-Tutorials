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

        
        UserService.polls(for: User.current) { (polls) in
            self.polls = polls
            self.tableView.reloadData()
        }
        configureTableView()
        
        // Do any additional setup after loading the view.
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
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
                                        
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourPollsCell", for: indexPath) as! YourPollsCell
        let poll = polls[indexPath.row]
        
        cell.delegate = self
        
        cell.profilePollText1.text = poll.content
        cell.profilePollText2.text = poll.content2
        
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
        
        cell.profilePollText1Per.text = String(format: "%.0f", poll.votePercent)
        cell.profilePollText2Per.text = String(format: "%.0f", poll.votePercent2)
        cell.pollUsername.text = String(poll.poster!)
        return cell
    }
    
}

extension ProfileViewController: YourPollsCellDelegate {
    func didTapVoteButton(_ pollTextButton: UIButton, pollNum: Int, on cell: YourPollsCell) {
        
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
        
        VoteService.voting(for: User.current, poll: poll)
        tableView.reloadData()
    }
    
}

extension Double {
    func roundTo2(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
        
    }
}





