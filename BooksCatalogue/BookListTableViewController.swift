//
//  BookListTableViewController.swift
//  BooksCatalogue
//
//  Created by Nayak, Nishant (external - Project) on 22/05/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

class BookListTableViewController: UITableViewController {
    
    var cellType = 0
    var filterType = 0
    var selectedBook: Book?
    
    var filteredList = [String]()
    var filteredBooks = [Book]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        fetchBooksDetails()
    }
    
    func fetchBooksDetails(){
        NetworkManager.sharedManager.fetchBooksDetails{ (booksArray, status) in
            if status{
                for item in booksArray{
                    let bookDict = item
                    let book = Book(bookId: bookDict["id"] as? String, book_title: bookDict["book_title"] as? String, author_name: bookDict["author_name"] as? String, genre: bookDict["genre"] as? String, publisher: bookDict["publisher"] as? String, author_country: bookDict["author_country"] as? String, soldCount: bookDict["sold_count"] as? Int, image_url: bookDict["image_url"] as? String)
                    Constants.sharedInstance.booksArray.append(book)
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch cellType {
        case 0:
            return Constants.sharedInstance.booksArray.count
        default:
            return filteredList.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // var cell: UITableViewCell?
        switch cellType {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.reuseIdentifier, for: indexPath) as! BookTableViewCell
            cell.bookTitle.text = Constants.sharedInstance.booksArray[indexPath.row].book_title ?? ""
            cell.bookImageView.image = nil
            cell.bookImageView.imageFromURL(urlString: Constants.sharedInstance.booksArray[indexPath.row].image_url!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterCellReuseIdentifier", for: indexPath)
            let label = cell.viewWithTag(101) as! UILabel
            label.text = filteredList[indexPath.row]
            return cell
        default:
            let cell = UITableViewCell()
            return cell
            print("default")
        }
        
        
        // Configure the cell...
        
        //return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch cellType {
        case 0:
            selectedBook = Constants.sharedInstance.booksArray[indexPath.row]
            self.performSegue(withIdentifier: "detailSegue", sender: self)
        case 1:
            switch filterType{
            case 0:
                filteredBooks.removeAll()
                filteredBooks = Constants.sharedInstance.booksArray.filter{ ($0).author_name == filteredList[indexPath.row]}
            case 1:
                filteredBooks.removeAll()
                filteredBooks = Constants.sharedInstance.booksArray.filter{ ($0).author_country == filteredList[indexPath.row]}
            default:
                print("default")
            }
            self.performSegue(withIdentifier: "filteredDetailsSegueId", sender: self)
        default:
            print("default")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "detailSegue"){
            let destinationController = segue.destination as! BookDetailViewController
            destinationController.booRef = selectedBook
        }
        else if (segue.identifier == "filteredViewReuseId"){
            let destinationController = segue.destination as! FilterTableViewController
            destinationController.delegate = self
        }
        else if (segue.identifier == "filteredDetailsSegueId"){
            let destinationController = segue.destination as! FilterDetailsListTableViewController
            destinationController.filteredBookArray = self.filteredBooks
        }
    }
 

}

extension BookListTableViewController: FilterBookList{
    func filterBookList(id: Int?) {
        cellType = 1
        var filteredSet = Set<String>()
        switch id {
        case 0:
            filterType = 0
            for item in Constants.sharedInstance.booksArray{
                filteredSet.insert(item.author_name ?? "")
            }
        case 1:
            filterType = 1
            for item in Constants.sharedInstance.booksArray{
                filteredSet.insert(item.author_country ?? "")
            }
        default:
            print("default")
        }
        
        filteredList.removeAll()
        for item in filteredSet{
            self.filteredList.append(item)
        }
        self.tableView.reloadData()
    }
    
    
}
