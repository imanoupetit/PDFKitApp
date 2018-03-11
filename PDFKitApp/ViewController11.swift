//
//  ViewController11.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 10/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController11: UIViewController {
    
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
        
        let searchButton = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createAndShareImage(_:)))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func createAndShareImage(_ sender: UIBarButtonItem) {
        guard let page = pdfView.currentPage else { return }
        let rect = page.bounds(for: PDFDisplayBox.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        
        /*
         // Also works
         let format = UIGraphicsImageRendererFormat()
         format.opaque = false
         format.scale = 2
         let renderer = UIGraphicsImageRenderer(size: rect.size, format: format)
         */
        
        let image = renderer.image(actions: { context in
            let cgContext = context.cgContext
            cgContext.translateBy(x: 0, y: rect.size.height)
            cgContext.scaleBy(x: 1, y: -1)
            page.draw(with: PDFDisplayBox.mediaBox, to: cgContext)
            
            /*
             // Also works
             UIColor.white.setFill()
             cgContext.saveGState()
             cgContext.translateBy(x: 0, y: rect.size.height)
             cgContext.scaleBy(x: 1, y: -1)
             cgContext.concatenate(pdfPage.transform(for: .mediaBox))
             pdfPage.draw(with: PDFDisplayBox.mediaBox, to: cgContext)
             cgContext.restoreGState()
             */
        })
        
        guard let data = UIImageJPEGRepresentation(image, 1) else { return }
        let activityItems = [data]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
}
