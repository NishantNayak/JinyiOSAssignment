//
//  Player.swift
//  Blasters
//
//  Created by Nayak, Nishant (external - Project) on 18/05/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import Foundation

class Book{
    var bookId: String?
    var book_title: String?
    var author_name: String?
    var genre: String?
    var publisher: String?
    var author_country: String?
    var soldCount: Int?
    var image_url: String?
    
    init(bookId:String?, book_title: String?, author_name: String?, genre: String?, publisher: String?, author_country: String?, soldCount: Int?, image_url: String?){
        self.bookId = bookId
        self.book_title = book_title
        self.author_name = author_name
        self.genre = genre
        self.publisher = publisher
        self.author_country = author_country
        self.soldCount = soldCount
        self.image_url = image_url
    }
}
