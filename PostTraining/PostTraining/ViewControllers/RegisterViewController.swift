//
//  RegisterViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passTxt: UITextField!
    
    @IBOutlet weak var confirmTxt: UITextField!
    
    var context:NSManagedObjectContext!
    
    @IBAction func registerClicked(_ sender: Any) {
        // let -> unmutable
        // var -> mutable
        // ambil value dr text
        let username = usernameTxt.text as! String
        let password = passTxt.text as! String
        let confirm = confirmTxt.text as! String
        
        if (password.isEmpty || username.isEmpty || confirm.isEmpty) {
            
        }
        
        // mskin db
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
        
        do {
            try context.save()
            if let nextView = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                navigationController?.pushViewController(nextView, animated: true)
            }
        }
        catch {
            print("Insert failed")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
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
