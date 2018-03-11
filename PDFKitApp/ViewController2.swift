//
//  ViewController2.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 08/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController2: UIViewController {

    let pdfView = PDFView()

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
        
        pdfDocument.delegate = self
        pdfView.document = pdfDocument
        pdfView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        pdfView.autoScales = true
    }

}

extension ViewController2: PDFDocumentDelegate {
    
    func classForPage() -> AnyClass {
        return WatermarkPage.self
    }
    
}

extension ViewController2: PDFViewDelegate {

    func pdfViewWillClick(onLink sender: PDFView, with url: URL) {
        print(url)
    }
    
}

class WatermarkPage: PDFPage {
    
    override func draw(with box: PDFDisplayBox, to context: CGContext) {
        super.draw(with: box, to: context)
        
        UIGraphicsPushContext(context)
        context.saveGState()
        
        let pageBounds = bounds(for: box)
        context.translateBy(x: 0, y: pageBounds.size.height)
        context.scaleBy(x: 1, y: -1)
        context.rotate(by: .pi / 4)
        
        let string: NSString = "User 3123-78"
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5),
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 100)
        ]
        
        string.draw(at: CGPoint(x: 240, y: 40), withAttributes: attributes)
        context.restoreGState()
        UIGraphicsPopContext()
    }
    
}

