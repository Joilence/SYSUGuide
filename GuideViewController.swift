//
//  GuideViewController.swift
//  SYSUGuide
//
//  Created by Jonathan Yang on 02/12/2016.
//  Copyright © 2016 JoilencePersonal. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController, UITextFieldDelegate {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultTableView.dataSource = self
        resultTableView.delegate = self
        destinationTextField.delegate = self
        startTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func guide(_ sender: UIButton) {
        let option = travelOption.selectedSegmentIndex
        resultCollection = storage.guide(aID: startID, bID: destinationID, option: travelWay(rawValue: option)!)
        resultTableView.reloadData()
    }
    
    
    // Data Picker
    func pickerChanged(sender: UIPickerView) {
        if inputStart {
            let row = sender.selectedRow(inComponent: 0)
            startTextField.text = storage.sceneCollection[row].name
        } else if inputDestination {
            let row = sender.selectedRow(inComponent: 0)
            destinationTextField.text = storage.sceneCollection[row].name
        } else {
            fatalError("ERROR: none of input triggered!()")
        }
    }
    
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
            startTextField.text = storage.sceneCollection[row].name
        } else if inputDestination {
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
        let cell = UITableViewCell()
        cell.textLabel?.text = resultCollection[row].name
        return cell
    }
}
