//
//  ViewController6.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 08/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

fileprivate let url = Bundle.main.url(forResource: "Document2", withExtension: "pdf")!

class ViewController6: UIViewController {
    
    let pdfView = PDFView()
    let pdfDocument = PDFDocument(url: url)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        pdfView.usePageViewController(true, withViewOptions: nil)
        pdfView.document = pdfDocument
        
        view.addSubview(pdfView)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let bounds = CGRect(x: 10, y: 10, width: 250, height: 100)
        let textFieldWidget = PDFAnnotation(bounds: bounds, forType: .widget, withProperties: nil)
        textFieldWidget.widgetFieldType = .text
        textFieldWidget.backgroundColor = .blue
        textFieldWidget.font = UIFont.systemFont(ofSize: 14)
        textFieldWidget.widgetStringValue = "Hello, World!"
        pdfDocument.page(at: 0)!.addAnnotation(textFieldWidget)
        
        let addAnnotationButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
        let rotationButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(rotate(_:)))
        navigationItem.rightBarButtonItems = [addAnnotationButton, rotationButton]
    }
    
    override func viewWillLayoutSubviews() {
        pdfView.autoScales = true
    }

    @objc func rotate(_ sender: UIBarButtonItem) {
        let page = pdfDocument.page(at: 0)!
        page.rotation += -90
        pdfView.setNeedsDisplay()
    }
    
    @objc func share(_ sender: UIBarButtonItem) {
        /*
         // Save to url style
         guard let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
         let urlPath = "\(directory)/newPDF.pdf"
         let saveUrl = URL(fileURLWithPath: urlPath)
         pdfDocument.write(to: saveUrl)
         let activityItems = [saveUrl]
         let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
         present(activityViewController, animated: true, completion: nil)
         */

        // Write to data style
        guard let data = pdfDocument.dataRepresentation() else { return }
        let activityItems = [data]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
}
