//
//  BookDetailViewController.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/17/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    //various label for the attributes of the book
    @IBOutlet weak var BookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var barCode: UILabel!
    @IBOutlet weak var bookPages: UILabel!
    @IBOutlet weak var readbook: UILabel!
    var bookList: Array<Books> = []
    
    var index = Int!()
    override func viewDidLoad() {
        super.viewDidLoad()
        let bookItem:Books!
        bookItem = bookList[index]
        BookTitle.text! = bookItem.bookTitle!
        bookAuthor.text! = bookItem.bookAuthor!
        barCode.text! = bookItem.barCode!
        bookPages.text! = bookItem.bookPages!
        readbook.text! = bookItem.readBook!
                                  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
}
