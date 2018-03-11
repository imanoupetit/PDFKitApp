//
//  ViewController13.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 11/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController13: UIViewController {
    
    let pdfView = PDFView()
    let pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "Document2", withExtension: "pdf")!)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let textView = UITextView()
        view.addSubview(textView)
        textView.frame = view.bounds
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let page = pdfDocument.page(at: 0)
        textView.attributedText = page?.attributedString
        textView.isEditable = false
    }
    
}
