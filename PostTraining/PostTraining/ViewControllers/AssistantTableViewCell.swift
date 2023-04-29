//
//  AssistantTableViewCell.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class AssistantTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var detailTxt: UITextField!
    var title: String = ""
    var detail: String = ""
    var row: Int = -1
    
    var arrTitle = [String]()
    var arrDetail = [String]()
    var context:NSManagedObjectContext!
    
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
        }
        catch {
            
        }
    }
//    var updateHandler = {
//
//    }
    
    var updateHandler: (()->Void)?
    var deleteHandler: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func editCell(newTitle:String, newDetail:String) {
        self.detail = newDetail
        detailTxt.text = detail
        self.title = newTitle
        titleTxt.text = title
    }
    
    
    @IBAction func updateClicked(_ sender: Any) {
        guard let t = titleTxt.text, let d = detailTxt.text else {return}
//        if t!=title || d!=detail {
            updateHandler?()
            title = t
            detail = d
//        }
    }
    
    
    @IBAction func deleteClicked(_ sender: Any) {
        deleteHandler?()
    }
    
//    func updateData(cell:AssistantTableViewCell, indexPath: IndexPath){
//        let oldTitle = arrTitle[indexPath.row]
//        let oldDetail = arrDetail[indexPath.row]
//        let newDetail = cell.detailTxt
//        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
//        req.predicate = NSPredicate(format: "title==%@", oldTitle)
//        do {
//            let res = try context.fetch(req) as! [NSManagedObject]
//            for todos in res {
//                todos.setValue(newDetail, forKey: "detail")
//            }
//            try context.save()
//            loadData()
//        } catch {
//
//        }
//    }
//
//    @IBAction func updateClicked(_ sender: Any) {
//        updateData(cell: self, indexPath: IndexPath(index: row))
//    }
    
    
//    @IBAction func updateClicked(_ sender: Any) {
//
//    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
