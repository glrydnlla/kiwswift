//
//  HomeViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var taskCount: UILabel!
    var arrTitle = [String]()
    var arrDetail = [String]()
    var context:NSManagedObjectContext!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AssistantTableViewCell
        cell.titleTxt.text = arrTitle[indexPath.row]
        cell.detailTxt.text = arrDetail[indexPath.row]
        cell.row = indexPath.row
        cell.updateHandler = {
            self.updateData(cell: cell, indexPath: indexPath)
        }
        cell.deleteHandler = {
            self.deleteData(indexPath: indexPath)
        }
        return cell
    }
    
    func updateData(cell:AssistantTableViewCell, indexPath: IndexPath){
        let oldTitle = arrTitle[indexPath.row]
        let oldDetail = arrDetail[indexPath.row]
        let newDetail = cell.detailTxt.text
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        req.predicate = NSPredicate(format: "title==%@", oldTitle)
        do {
            let res = try context.fetch(req) as! [NSManagedObject]
            for todos in res {
                todos.setValue(newDetail, forKey: "detail")
            }
            try context.save()
            loadData()
        } catch {
            
        }
    }
    
    @IBOutlet weak var titleTxt: UITextField!
    
    @IBOutlet weak var detailTxt: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func insertClicked(_ sender: Any) {
        let detail = detailTxt.text!.capitalized
        let title = titleTxt.text!.uppercased()
        let entity = NSEntityDescription.entity(forEntityName: "ToDo", in: context)
        let newAssistant = NSManagedObject(entity: entity!, insertInto: context)
        newAssistant.setValue(detail, forKey: "detail")
        newAssistant.setValue(title, forKey: "title")
        do {
            try context.save()
            loadData()
        }
        catch {
            
        }
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        print("settings clicked kiw")
        if let nextView = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") {
            navigationController?.pushViewController(nextView, animated: true)
        }
    }
    
    func loadData() {
        arrTitle.removeAll()
        arrDetail.removeAll()
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        do {
            let res = try context.fetch(req) as! [NSManagedObject]
            for data in res {
                arrTitle.append(data.value(forKey: "title") as! String)
                arrDetail.append(data.value(forKey: "detail") as! String)
            }
            taskCount.text = "Total task : " + String(res.count)
            tableView.reloadData()
        }
        catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteData(indexPath: indexPath)
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        let title = arrTitle[indexPath.row]
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        req.predicate = NSPredicate(format: "title == %@", title)
        do {
            let res = try context.fetch(req) as! [NSManagedObject]
            for data in res {
                context.delete(data)
            }
            try context.save()
            loadData()
        }
        catch {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
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
