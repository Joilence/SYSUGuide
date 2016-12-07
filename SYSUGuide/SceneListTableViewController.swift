//
//  SceneListTableViewController.swift
//  SYSUGuide
//
//  Created by Jonathan Yang on 07/12/2016.
//  Copyright © 2016 JoilencePersonal. All rights reserved.
//

import UIKit

class SceneListTableViewController: UITableViewController {

    let storage = Storage()
    
    @IBOutlet var sceneListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneListTableView.register(SceneListTableViewCell.self, forCellReuseIdentifier: "SceneListCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.sceneCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = sceneListTableView.dequeueReusableCell(withIdentifier: "SceneListCell") as! SceneListTableViewCell
        cell.textLabel?.text = storage.sceneCollection[row].name
        cell.name = storage.sceneCollection[row].name
        cell.descriptionDetail = storage.sceneCollection[row].description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowSceneDetail", sender: sceneListTableView.cellForRow(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! SceneListTableViewCell
        let desVC = segue.destination as! DetailViewController
        desVC.relatedScene = Scene(name: cell.name, id: 0, description: cell.descriptionDetail)
        
    }
    

}
