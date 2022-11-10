//
//  HistroyCallsTableViewController.swift
//  FakeCall
//
//  Created by Денис  on 27.10.2022.
//

import UIKit
import CoreData

class HistroyCallsTableViewController: UITableViewController {
    
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ContactUser")
        var sortDesriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDesriptor]
        let fetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                         managedObjectContext: CoreDataManager.shared.context,
                                                         sectionNameKeyPath: nil,
                                                         cacheName: nil)
        return fetchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ContactTableViewCell {
            let contact = fetchResultController.object(at: indexPath) as! ContactUser
            cell.titleContactLabel.text = contact.title
            cell.contactPhotoimaveView.image = UIImage(data: contact.userImage ?? NSData() as Data)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController?.selectedIndex = 0
    }

    // delete cells
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contact = fetchResultController.object(at: indexPath) as! ContactUser
            CoreDataManager.shared.context.delete(contact)
            CoreDataManager.shared.saveContext()
        }
    }
}

extension HistroyCallsTableViewController: NSFetchedResultsControllerDelegate {
    
    // Inform about the beginning of data changes
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            break
        case .update:
            break
        default:
            break
        }
    }
    
    // Inform about the end of the data change
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}



