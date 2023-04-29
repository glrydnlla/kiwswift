//
//  SettingsViewController.swift
//  PostTraining
//
//  Created by prk on 27/04/23.
//

import UIKit

class SettingsViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.traitCollection.userInterfaceStyle == .dark) {
            if let themeSwitch = self.view.viewWithTag(178) as? UISwitch {
                themeSwitch.isOn = true
            }
        }
        else {
            if let themeSwitch = self.view.viewWithTag(178) as? UISwitch {
                themeSwitch.isOn = false
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if (sender.isOn) {
            UIApplication.shared.windows.forEach{
                window in window.overrideUserInterfaceStyle = .dark
            }
        } else {
            UIApplication.shared.windows.forEach{
                window in window.overrideUserInterfaceStyle = .light
            }
        }
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
