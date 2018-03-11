//
//  ViewController5.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 08/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController5: UIViewController {
    
    let pdfView = PDFView()
    let pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "Document2", withExtension: "pdf")!)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        pdfView.backgroundColor = .red
        pdfView.documentView?.backgroundColor = .green

        pdfView.usePageViewController(true, withViewOptions: nil)
        pdfView.document = pdfDocument
        
        view.addSubview(pdfView)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let addAnnotationButton = UIBarButtonItem(title: "Annotate", style: .plain, target: self, action: #selector(addAnnotationTapped2(_:)))
        navigationItem.rightBarButtonItem = addAnnotationButton
    }
    
    override func viewWillLayoutSubviews() {
        pdfView.autoScales = true
    }
    
    @objc func addAnnotationTapped(_ sender: UIBarButtonItem) {
        let bounds = CGRect(x: 10, y: 10, width: 100, height: 100)
        let annotation = PDFAnnotation(bounds: bounds, forType: .square, withProperties: nil)
        annotation.color = .red
        let border = PDFBorder()
        border.lineWidth = 2
        annotation.border = border
        pdfDocument.page(at: 0)!.addAnnotation(annotation)
    }
    
    @objc func addAnnotationTapped2(_ sender: UIBarButtonItem) {
        let bounds = CGRect(x: 10, y: 10, width: 250, height: 100)
        let textFieldWidget = PDFAnnotation(bounds: bounds, forType: .widget, withProperties: nil)
        textFieldWidget.widgetFieldType = .text
        textFieldWidget.backgroundColor = .blue
        textFieldWidget.font = UIFont.systemFont(ofSize: 14)
        textFieldWidget.widgetStringValue = "Hello, World!"
        pdfDocument.page(at: 0)!.addAnnotation(textFieldWidget)
    }

    @objc func addAnnotationTapped3(_ sender: UIBarButtonItem) {
        let bounds = CGRect(x: 10, y: 10, width: 250, height: 100)
        let widget = PDFAnnotation(bounds: bounds, forType: .widget, withProperties: nil)
        widget.widgetFieldType = .signature
        pdfDocument.page(at: 0)!.addAnnotation(widget)
    }

}
