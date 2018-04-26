//
//  PlayersViewController.swift
//  Bundesliga App
//
//  Created by Admin on 11/25/17.
//  Copyright © 2017 ITI. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController , UITableViewDelegate  , UITableViewDataSource{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var playersArray :[Players] = []
    
//    var sortedFirstLetters: [String] = []
//    var sections: [[Players]] = [[]]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = UserDefaults.standard.object(forKey: "title") as? String
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
     //generateWordDict()
}

    
    var wordSection = [String]()
    var wordDictionary  = [String : [String]]()
    
    
    func generateWordDict() {
    
        for player in playersArray {
        
        
        
        let key = "\(player.playerName[player.playerName.startIndex])"
         let lower = key.lowercased()
            
            
            if var wordValues = wordDictionary[lower] {
            
            wordValues.append(player.playerName)
                
               wordDictionary[lower] = wordValues

            }else {
            
            wordDictionary[lower] = [player.playerName]
            
            }
        
        
        wordSection = [String](wordDictionary.keys)
        
    wordSection = wordSection.sorted()
        
        
        
        
        
        }
        
        
    
    
    
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadPlayersData()
    
//        let firstLetters = self.playersArray.map { $0.titleFirstLetter }
//        let uniqueFirstLetters = Array(Set(firstLetters))
//        
//        self.sortedFirstLetters = uniqueFirstLetters.sorted()
//        self.sections = self.sortedFirstLetters.map { firstLetter in
//            return self.playersArray
//                .filter { $0.titleFirstLetter == firstLetter }
//                .sorted { $0.playerName < $1.playerName }
//        }
    }
    
    func loadPlayersData() {
        
        let urlStr = UserDefaults.standard.object(forKey: "teamPlayerHref") as? String
        
        let url = "\(urlStr!)"
        
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
                    
                    let arrJSON = fetchData["players"] as! [[String : Any]]
                    
                  
                    
                    for eachFetchPlayer in arrJSON {
                        
                   
                        
                        
                        let  playerName  = eachFetchPlayer["name"] as! String
                        
                        let playerPosition = eachFetchPlayer["position"] as! String
                        
                        
                        
                        
                        
                        self.playersArray.append(Players(playerName: playerName, playerPosition: playerPosition))
                        
                        
                    }
                    
                   
                    
                    print(self.playersArray[0].playerName)
                   

                    self.tableView.reloadData()
                    
                    
                    
                    
                    
                    
                }
                catch{
                    
                    
                    
                    print(" error catch")
                    
                    
                }
                
            }
            
            
           
            
        }
      
        task.resume()
        
        
      
        
    }
    
    
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        
//        
//        
//        return playersArray.count
//        
//    }
    
    
    
//  public  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//   
//    
//        return wordSection[section]
//    
    //}
//
//   public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return sortedFirstLetters
//    }
//    
//   public func numberOfSections(in tableView: UITableView) -> Int {
//        return wordSection.count
//    }
    
     public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        //return sections[section].count
         return playersArray.count
//        
//        let contactKey = wordSection[section]
//        if let contactValue = wordDictionary[contactKey]{
//            return contactValue.count
//        }
//        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as?  TeamsTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! PlayersTableViewCell
        
//        cell.playerName.text =  sections[indexPath.section][indexPath.row].playerName
//         cell.playerPosition.text = sections[indexPath.section][indexPath.row].playerPosition
        cell.playerName.text =  playersArray[indexPath.row].playerName
        cell.playerPosition.text = playersArray[indexPath.row].playerPosition

       // playersArray
        
        
//        let cotactkey = wordSection[indexPath.section]
//        
//        if  let contactValue = wordDictionary[cotactkey.lowercased()] {
//            cell.playerName.text =  playersArray[indexPath.row].playerName
//            cell.playerPosition.text = playersArray[indexPath.row].playerPosition
//        }
       return cell
        
    }
    
//    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return wordSection
//    }

}
