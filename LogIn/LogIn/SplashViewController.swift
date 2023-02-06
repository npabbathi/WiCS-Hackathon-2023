//
//  SplashViewController.swift
//  SplashScreen
//
//  Created by Ananya Chintalapudi on 2/5/23.
//

import UIKit

class SplashViewController: UIViewController {


    @IBOutlet weak var splashScreenLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashScreenLabel.text = ""
        let titleText = "mag.net"
        var charIndex = 0.0
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { (timer) in
                self.splashScreenLabel.text?.append(letter)
            }
            charIndex += 1
        }

        imageView.loadGif(name: "walkDown 3")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            
            mainVC.modalPresentationStyle = .fullScreen
            mainVC.modalTransitionStyle = .flipHorizontal
            self.present(mainVC, animated: true) {
                
                UIView.animate(withDuration: 1.0, delay: 0.5, options: .autoreverse, animations: {
                    self.view.alpha = 0
                }, completion: nil)
            }
        }
    }
    



}
