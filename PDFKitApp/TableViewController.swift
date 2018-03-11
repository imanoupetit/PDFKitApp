//
//  TableViewController.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 10/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

/**
 Sources:
 - http://www.tekramer.com/building-a-pdf-viewer-with-pdfkit-in-ios-11
 - https://medium.com/@jeffh2170/pdfkit-pdfview-8f2be66a4c8f
 - https://medium.com/mindorks/rendering-pdf-documents-using-pdfkit-9ac4944a6dfb
 - http://sketchytech.blogspot.fr/2015/05/adventures-in-pdf-swift-and-pdfkit.html
 */

import UIKit

struct Model {
    let title: String
    let controller: UIViewController.Type
}

class TableViewController: UITableViewController {
    
    let array = [
        Model(title: "Scroll by Page and resize", controller: ViewController1.self),
        Model(title: "Watermark and link click", controller: ViewController2.self),
        Model(title: "Thumbnails view", controller: ViewController3.self),
        Model(title: "Notify change of page", controller: ViewController4.self),
        Model(title: "Annotate PDF", controller: ViewController5.self),
        Model(title: "Share PDF and rotate", controller: ViewController6.self),
        Model(title: "Search by highlighting (WIP)", controller: ViewController7.self),
        Model(title: "Move annotation (WIP)", controller: ViewController8.self),
        Model(title: "Resize annotation (WIP)", controller: ViewController9.self),
        Model(title: "Prevent selection", controller: ViewController10.self),
        Model(title: "Image from PDFPage", controller: ViewController11.self),
        Model(title: "Get thumbnail", controller: ViewController12.self),
        Model(title: "Get page text", controller: ViewController13.self)
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "#\(indexPath.row + 1). \(array[indexPath.row].title)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = array[indexPath.row]
        let controllerToPresent = model.controller.init()
        controllerToPresent.title = model.title
        show(controllerToPresent, sender: nil)
    }
    
}
