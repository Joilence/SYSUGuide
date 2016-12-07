//
//  DetailViewController.swift
//  SYSUGuide
//
//  Created by Jonathan Yang on 08/12/2016.
//  Copyright © 2016 JoilencePersonal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var sceneTitle: UILabel!
    @IBOutlet var descriptionDetail: UILabel!
    
    var relatedScene = Scene(name: "", id: 0, description: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneTitle.text = relatedScene.name
        descriptionDetail.text = relatedScene.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
