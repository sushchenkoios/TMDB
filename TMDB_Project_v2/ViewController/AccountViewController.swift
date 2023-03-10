//
//  AccountViewController.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 06.03.2023.
//

import UIKit
import Lottie

class AccountViewController: UIViewController {
    
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.75
        animationView.play()
        
        //#02B3E0
        let color1 = UIColor(red: 2/255, green: 179/255, blue: 224/255, alpha: 1).cgColor
        //#89CCA4
        let color2 = UIColor(red: 137/255, green: 204/255, blue: 164/255, alpha: 1.0).cgColor
        //#02B3E0
        //let color3 = UIColor(red: 2/255, green: 179/255, blue: 224/255, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
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
