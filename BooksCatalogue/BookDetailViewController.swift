//
//  BookDetailViewController.swift
//  BooksCatalogue
//
//  Created by Nayak, Nishant (external - Project) on 22/05/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookId: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var unitsSold: UILabel!
    
    var booRef: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateFields()
        // Do any additional setup after loading the view.
    }
    
    func populateFields(){
        self.bookImageView.imageFromURL(urlString: booRef?.image_url ?? "")
        self.bookTitle.text = booRef?.book_title ?? ""
        self.bookId.text = booRef?.bookId ?? ""
        self.author.text = booRef?.author_name ?? ""
        self.genre.text = booRef?.genre ?? ""
        self.unitsSold.text = String(booRef?.soldCount ?? 0)
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
