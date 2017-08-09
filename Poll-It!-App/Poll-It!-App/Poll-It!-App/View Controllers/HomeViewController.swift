//
//  HomeViewController.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-24.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth 


class HomeViewController: UIViewController {

    
     var polls = [Poll]()

    
    
   

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self 
        
        
//        PollService.allPolls(for: User.current) { (polls) in
//            
//            self.polls = polls
//            self.tableView.reloadData()
//            
//        }
//        
     
        
        
        configureTableView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.delegate = self
        
        PollService.allPolls(for: User.current) { (polls) in
            
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

    func reportButtonTap(from cell: YourPollsCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let poll = polls[indexPath.row]
        let poster = poll.poster.uid
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if poster != User.current.uid {
            let flagAction = UIAlertAction(title: "Report as Inappropriate", style: .default) { _ in
                PollService.flag(poll)
                
                let okAlert = UIAlertController(title: nil, message: "The post has been flagged.", preferredStyle: .alert)
                okAlert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(okAlert, animated: true)
            }
            
            alertController.addAction(flagAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourPollsCell", for: indexPath) as! YourPollsCell
        let poll = polls[indexPath.row]
        
        cell.delegate = self
        cell.didTapOptionsButtonForCell = reportButtonTap(from:)
        
        cell.pollText1View.text = poll.content
        cell.pollText2View.text = poll.content2
        cell.pollTitle.text = poll.title
        
        poll.votePercent =
            (Double(poll.voteCount) / Double((poll.voteCount + poll.voteCount2)) * Double(100)).roundTo(places: 2)
        poll.votePercent2 = (Double(poll.voteCount2) / Double((poll.voteCount + poll.voteCount2)) * Double(100)).roundTo(places: 2)
        
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
        
        cell.pollText1Percent.text = String(format: "%.0f", poll.votePercent)
        cell.pollText2Percent.text = String(format: "%.0f", poll.votePercent2)
        
//        cell.pollUsername.text = String(poll.poster!)
        
        return cell
    }
    
}

extension HomeViewController: YourPollsCellDelegate {
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
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
        
    }
}

extension HomeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "add") as! AddPollViewController
            
            self.present(vc, animated: true, completion: nil)
            
            return false
        }
        return true
    }
}
