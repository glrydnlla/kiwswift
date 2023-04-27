//
//  ViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passTxt: UITextField!
    
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let username = usernameTxt.text!
        let pass = passTxt.text!
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        req.predicate = NSPredicate(format: "username == %@ AND password == %@", username, pass)
        do {
            let result = try context.fetch(req) as! [NSManagedObject]
            if result.count == 0 {
                print("Login failed")
            }
            else {
                print("login success")
                if let nextView = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                    navigationController?.pushViewController(nextView, animated: true)
                }
            }
        }
        catch {
            
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
