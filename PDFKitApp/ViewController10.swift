//
//  ViewController10.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 09/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController10: UIViewController {
    
    let pdfView = NonSelectablePDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        guard
            let url = Bundle.main.url(forResource: "Document2", withExtension: "pdf"),
            let pdfDocument = PDFDocument(url: url)
            else { return }
        
        pdfView.frame = view.bounds
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(pdfView)
        
        pdfView.document = pdfDocument
    }
    
    override func viewWillLayoutSubviews() {
        pdfView.autoScales = true
    }
    
}

class NonSelectablePDFView: PDFView {
    
    /*
     // Alternative
     override init(frame: CGRect) {
         super.init(frame: frame)

         if let gestureRecognizers = gestureRecognizers {
             for gestureRecognizer in gestureRecognizers where gestureRecognizer is UILongPressGestureRecognizer {
                 gestureRecognizer.isEnabled = false
             }
         }
     }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     */
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

    override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        (gestureRecognizer as? UILongPressGestureRecognizer)?.isEnabled = false
        super.addGestureRecognizer(gestureRecognizer)
    }
    
}
