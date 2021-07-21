//
//  FloatingViewController.swift
//  RicknMortyTrial
//
//  Created by Henit Work on 20/07/21.
//

import UIKit
import Kingfisher

class FloatingViewController: UIViewController {

    @IBOutlet weak var characterView: UIView!
    @IBOutlet weak var characterLAL: UILabel!
    @IBOutlet weak var characterGender: UILabel!
    @IBOutlet weak var characterOrigin: UILabel!
    @IBOutlet weak var characterStatus: UILabel!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    var lal = ""
    var gen = ""
    var ori = ""
    var sta = ""
    var nam = ""
    var img = ""

    override func viewWillAppear(_ animated: Bool) {
        characterImage.layer.cornerRadius = 10
        characterView.layer.cornerRadius = 20
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.main.async {
            self.characterName.text = self.nam
            self.characterOrigin.text = self.ori
            self.characterLAL.text = self.lal
            self.characterStatus.text = self.sta
            self.characterGender.text = self.gen
            let resourse = ImageResource.init(downloadURL: URL(string: self.img)!)
            self.characterImage.kf.setImage(with: resourse)
        }
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
