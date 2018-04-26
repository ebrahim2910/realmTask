//
//  ViewController.swift
//  Bundesliga App
//
//  Created by Admin on 11/25/17.
//  Copyright © 2017 ITI. All rights reserved.
//

import UIKit

import RealmSwift


import CoreData

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var teamsArray = [Teams]()
    
    var model :  TeamDataBaseModel?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ConnectionCheck.isConnectedToNetwork() {
            print("Connected")
        }
        else{
            print("disConnected")
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        loadTeamsData()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadTeamsData() {
        
        let url = "http://api.football-data.org/v1/competitions/430/teams"
        
        var request = URLRequest(url : URL(string :url)!)
        
        request.httpMethod = "GET"
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration , delegate: nil , delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request){(data, response , error) in
            
            if (error != nil ){
                
                
                print("error")
                
                
            } else {
                
                
                
                
                do{
                    
                    let fetchData = try JSONSerialization.jsonObject(with: data! , options:JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                    
                    let arrJSON = fetchData["teams"] as! [[String : Any]]
                    
                    //let playersArray =  arrJSON["players"] as!  [[String : Any]]
                    
                    for eachFetchTeams in arrJSON {
                        
                        
                        
                        let  teamName  = eachFetchTeams["name"] as! String
                        
                        let teamImage = eachFetchTeams["crestUrl"] as! String
                        
                        
                        let links = eachFetchTeams["_links"] as! [String : Any]
                        
                        
                        let players = links["players"] as! [String : Any]
                        
                        let href = players["href"] as! String
                        
                        let shortName = eachFetchTeams["shortName"] as! String
                        
                        self.model = TeamDataBaseModel()
                        
                        //Set properties in it
                        self.model!.teamNameDataBase = teamName
                        self.model!.shortName = shortName
                        if let data = self.model{
                            //Check if the entered 'id' is not already present
                            if self.ifIdExists(findID: shortName) == nil {
                                try! self.realm.write {
                                    //Add object to Realm
                                    self.realm.add(data)
                                    
                                }
                            }
                        }
                        
                        self.teamsArray.append(Teams(teamName: teamName, teamImage: teamImage, teamPlayersLink: href, shortName: shortName))
                        
                    }
                    
                    
                    
                    print(self.teamsArray)
                    
                    self.tableView.reloadData()
                    
                    
                    
                    
                    
                    
                }
                catch{
                    
                    
                    
                    print(" error catch")
                    
                    
                }
                
            }
            
            
            
            
        }
        task.resume()
        
        
        
    }
    
    
    
    func ifIdExists(findID: String) -> TeamDataBaseModel?{
        
        let predicate = NSPredicate(format: "shortName = %@", findID)
        let object = self.realm.objects(TeamDataBaseModel.self).filter(predicate).first
        if object?.shortName == findID {
            
            return object
            
        }
        return nil
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if ConnectionCheck.isConnectedToNetwork() {
            print("Connected")
            return teamsArray.count
        }
        else{
            print("disConnected")
            
            return realm.objects(TeamDataBaseModel.self).count
        }
        
        // return teamsArray.count
        
        
    }
    
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as?  TeamsTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TeamsTableViewCell
        
        if ConnectionCheck.isConnectedToNetwork() {
            print("Connected")
            cell.teamName.text = teamsArray[indexPath.row].teamName
            
            //        cell.teamImage.sd_setImage(with: URL(string: teamsArray[indexPath.row].teamImage ), placeholderImage: UIImage(named: "placeholder.svg")) 
            
            if let url = URL(string: teamsArray[indexPath.row].teamImage ) {
                let request = URLRequest(url: url)
               cell.webView.loadRequest(request)
            }
        }
        else{
            print("disConnected")
            let model = self.realm.objects(TeamDataBaseModel.self)[indexPath.row]
            cell.teamName.text! = model.teamNameDataBase!
            
        }
        
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if ConnectionCheck.isConnectedToNetwork() {
            print("Connected")
            
            UserDefaults.standard.set( teamsArray[indexPath.row].teamPlayersLink, forKey: "teamPlayerHref")
            
            UserDefaults.standard.set( teamsArray[indexPath.row].teamName, forKey: "title")
            performSegue(withIdentifier: "toPlayers", sender: nil)
            
        }
        
        
    }
    
    
    
    
    
}
