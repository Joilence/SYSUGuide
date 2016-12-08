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
        
        switch relatedScene.id {
        case 0:
            imageView.image = #imageLiteral(resourceName: "image0")
        case 1:
            imageView.image = #imageLiteral(resourceName: "image1")
        case 2:
            imageView.image = #imageLiteral(resourceName: "image2")
        case 3:
            imageView.image = #imageLiteral(resourceName: "image3")
        case 4:
            imageView.image = #imageLiteral(resourceName: "image4")
        case 5:
            imageView.image = #imageLiteral(resourceName: "image5")
        case 6:
            imageView.image = #imageLiteral(resourceName: "image6")
        case 7:
            imageView.image = #imageLiteral(resourceName: "image7")
        case 8:
            imageView.image = #imageLiteral(resourceName: "image8")
        default:
            break
        }
        
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
