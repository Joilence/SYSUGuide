//
//  GuideViewController.swift
//  SYSUGuide
//
//  Created by Jonathan Yang on 02/12/2016.
//  Copyright © 2016 JoilencePersonal. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var travelOption: UISegmentedControl!
    
    var inputStart = false
    var inputDestination = false

    var startID = 0
    var destinationID = 0
    
    var storage = Storage()
    
    var resultCollection = [Scene]()
    @IBOutlet var resultTableView: UITableView!
    @IBOutlet var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTableView.register(SceneListTableViewCell.self, forCellReuseIdentifier: "SceneListCell")

        resultTableView.dataSource = self
        resultTableView.delegate = self
        destinationTextField.delegate = self
        startTextField.delegate = self
        
        storage.solveWalk()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func guide(_ sender: UIButton) {
        let option = travelOption.selectedSegmentIndex
        print("Check Path from \(startID) to \(destinationID)")
        resultCollection = storage.getPathCollection(startID: startID, destinationID: destinationID)
        var time: Double = Double(storage.getTime(startID: startID, destinationID: destinationID))
        if option == 0 {
            time = Double(time)
        } else {
            time = Double(time) / 2.5
        }
        let timeInt = Int(time)
        timeLabel.text = "About \(timeInt) min."
        startTextField.resignFirstResponder()
        destinationTextField.resignFirstResponder()
        resultTableView.reloadData()
    }
    
}

extension GuideViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if inputStart {
            startTextField.resignFirstResponder()
            return true
        } else if inputDestination {
            destinationTextField.resignFirstResponder()
            return true
        } else {
            fatalError("ERROR: none of input triggered!(textFieldShouldReturn())")
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.restorationIdentifier == "start" {
            inputStart = true
            inputDestination = false
        } else if textField.restorationIdentifier == "destination" {
            inputDestination = true
            inputStart = false
        } else {
            fatalError("ERROR: none of input triggered!(textFieldDidEditting)")
        }
        let picker = UIPickerView()
        textField.inputView = picker
        picker.dataSource = self
        picker.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        inputStart = false
        inputDestination = false
    }

}


extension GuideViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return storage.sceneCollection.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return storage.sceneCollection[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if inputStart {
            startID = row
            startTextField.text = storage.sceneCollection[row].name
        } else if inputDestination {
            destinationID = row
            destinationTextField.text = storage.sceneCollection[row].name
        } else {
            fatalError("ERROR: none of input triggered!(didSelectedRow)")
        }
    }
}

extension GuideViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultCollection.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = resultTableView.dequeueReusableCell(withIdentifier: "SceneListCell") as! SceneListTableViewCell
        cell.textLabel?.text = resultCollection[row].name
        cell.name = resultCollection[row].name
        cell.descriptionDetail = resultCollection[row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowSceneDetail", sender: resultTableView.cellForRow(at: indexPath))
        resultTableView.deselectRow(at: indexPath, animated: true)
        startTextField.resignFirstResponder()
        destinationTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! SceneListTableViewCell
        let desVC = segue.destination as! DetailViewController
        let row = (resultTableView.indexPathForSelectedRow?.row)!
        let scene = resultCollection[row]
        desVC.relatedScene = Scene(name: cell.name, id: scene.id, description: cell.descriptionDetail)
    }
}
