//
//  ViewController7.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 08/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController7: UIViewController {
    
    let pdfView = PDFView()
    let pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "Document2", withExtension: "pdf")!)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        pdfView.backgroundColor = .red
        pdfView.usePageViewController(true, withViewOptions: nil)
        pdfView.document = pdfDocument
        
        view.addSubview(pdfView)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        pdfView.autoScales = true
        pdfDocument.delegate = self
        
        let searchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(search(_:)))
        let stopSearchButton = UIBarButtonItem(title: "Stop", style: .plain, target: self, action: #selector(stopSearch(_:)))
        navigationItem.rightBarButtonItems = [searchButton, stopSearchButton]
    }
    
    @objc func search(_ sender: UIBarButtonItem) {
        pdfDocument.beginFindString("iPhone and iPad can transform", withOptions: [NSString.CompareOptions.caseInsensitive])
    }

    @objc func stopSearch(_ sender: UIBarButtonItem) {
        pdfView.highlightedSelections = nil
    }
    
    var searchItems = [PDFSelection]()

}

extension ViewController7: PDFDocumentDelegate {
    
    func documentDidBeginDocumentFind(_ notification: Notification) {
//        searchItems.removeAll()
        /*
         if (!_searchedItems){
            _searchedItems = [[NSMutableArray alloc]init];
         }
         */
    }
    
    func documentDidEndDocumentFind(_ notification: Notification) {
        pdfView.highlightedSelections = searchItems
//        searchItems.removeAll()
    }
    
    func didMatchString(_ instance: PDFSelection) {
        print(String(describing: instance.attributedString?.string))
        instance.color = .red
        searchItems.append(instance)
    }
    
}
