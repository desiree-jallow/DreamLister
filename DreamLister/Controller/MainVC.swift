//
//  ViewController.swift
//  DreamLister
//
//  Created by Desiree on 11/24/20.
//

import CoreData
import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        generateDummyData()
        attempFetch()
    }
    
}

extension MainVC {
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        attempFetch()
        tableView.reloadData()
    }
}
//MARK: - TableView Setup
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseID, for: indexPath) as? ItemCell else {
                return UITableViewCell()
        }
        configureCell(cell, indexPath: indexPath)
        return cell
    
   }
    
    func configureCell(_ cell: ItemCell, indexPath: IndexPath) {
        let item = controller.object(at: indexPath)
        cell.configCell(item)
    }
}

//MARK: - Core Data Setup
extension MainVC: NSFetchedResultsControllerDelegate {
    func generateDummyData() {
        let item1 = Item(context: Constants.context)
        item1.name = "MacBook Pro"
        item1.price = 3000
        item1.details = "I'd really like a new macbook with a keyboard that doesnt break all the time..."
        
        let item2 = Item(context: Constants.context)
        item2.name = "Bose an700 Headphones"
        item2.price = 349
        item2.details = "They are pricey but being able to block out other people is worth it."
        
        let item3 = Item(context: Constants.context)
        item3.name = "Tesla Model Y"
        item3.price = 62000
        item3.details = "This is like buying the future"
        
            Constants.appDelegate.saveContext()
    }
    
    func attempFetch() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "name", ascending: true)
        
      
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            fetchRequest.sortDescriptors = [dateSort]
        case 1:
            fetchRequest.sortDescriptors = [priceSort]
        case 2:
            fetchRequest.sortDescriptors = [titleSort]
        default:
            break
        }
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: Constants.context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
}

