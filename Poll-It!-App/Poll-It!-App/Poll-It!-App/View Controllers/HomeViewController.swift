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
        
        UserService.polls(for: User.current) { (polls) in
            self.polls = polls
            self.tableView.reloadData()
        }
        
        

        
        configureTableView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.delegate = self
        
        UserService.polls(for: User.current) { (polls) in
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

    
    
    
//    func didTapVoteButton(_ polltext1Button: UIButton, on cell: YourPollsCell) {
//        // 1
//        guard let indexPath = tableView.indexPath(for: cell)
//            else { return }
//        
//        // 2
//        polltext1Button.isUserInteractionEnabled = false
//        // 3
//        let post = polls[indexPath.section]
//        
//        // 4
//        VoteService.setIsVoted(!poll.isPollVoted, for: poll) { (success) in
//            // 5
//            defer {
//                polltext1Button.isUserInteractionEnabled = true
//            }
//            
//            // 6
//            guard success else { return }
//            
//            // 7
//            poll.voteCount += !poll.isVoted ? 1 : -1
//            poll.isVoted = !poll.isVoted
//            
//            // 8
//            guard let cell = self.tableView.cellForRow(at: indexPath) as? YourPollsCell
//                else { return }
//            
//            // 9
//            DispatchQueue.main.async {
//                self.configureCell(cell, with: poll)
//            }
//        }
//    }
    

    
    
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



extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourPollsCell", for: indexPath) as! YourPollsCell
        let poll = polls[indexPath.row]
        
        cell.delegate = self
        
        cell.pollText1View.text = poll.content
        cell.pollText2View.text = poll.content2
        cell.pollText1Percent.text = String(format: "%.2f", poll.votePercent)
        cell.pollText2Percent.text = String(format: "%.2f", poll.votePercent2)
        cell.pollUsername.text = String(poll.poster!)
        
        
//        cell.pollText1Percent.text = "\(poll.voteCount! / (poll.voteCount! + poll.voteCount2!))%"
//        cell.pollText2Percent.text =  "\(poll.voteCount2! / (poll.voteCount! + poll.voteCount2!))%"
        
        return cell
    }
    
}

extension HomeViewController: YourPollsCellDelegate {
    func didTapVoteButton(_ pollTextButton: UIButton, pollNum: Int, on cell: YourPollsCell) {
        
        guard let indexPath = tableView.indexPath(for: cell)
            else { return }
        

        let poll = polls[indexPath.row]
        
        if pollNum == 1 || pollNum == 2 {
            pollTextButton.isEnabled = false
        }
       

        
        if pollNum == 1 {
            poll.voteCount += 1
//            pollTextButton.isEnabled = false
            
//            if poll.voteCount == 2{
//                poll.voteCount -= 2
//                poll.votePercent = 0.00
//            }
//            
//            else if poll.voteCount > 2 {
//                poll.voteCount += 0
//            }
            
        }
        
        else if pollNum == 2 {
            poll.voteCount2 += 1
//            pollTextButton.isEnabled = false
            
//            if poll.voteCount2 == 2{
//                poll.voteCount2 -= 2
//                poll.votePercent2 = 0.00
//            }
//            
//            else if poll.voteCount2 > 2 {
//                poll.voteCount2 += 0
//            }
            
        }
        
        poll.votePercent =
            (Double(poll.voteCount) / Double((poll.voteCount + poll.voteCount2)) * Double(100)).roundTo(places: 2)
        poll.votePercent2 = (Double(poll.voteCount2) / Double((poll.voteCount + poll.voteCount2)) * Double(100)).roundTo(places: 2)
        
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
