//
//  ViewController3.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 08/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController3: UIViewController {
    
    let pdfView = PDFView()
    let pdfThumbnailView = PDFThumbnailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        guard
            let url = Bundle.main.url(forResource: "Document2", withExtension: "pdf"),
            let pdfDocument = PDFDocument(url: url)
            else { return }
        
        pdfView.backgroundColor = .red
        pdfView.usePageViewController(true, withViewOptions: nil)
        pdfView.document = pdfDocument

        pdfThumbnailView.pdfView = pdfView
        pdfThumbnailView.layoutMode = .vertical
        pdfThumbnailView.thumbnailSize = CGSize(width: 44, height: 44)
        pdfThumbnailView.backgroundColor = .groupTableViewBackground

        view.addSubview(pdfView)
        view.addSubview(pdfThumbnailView)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfThumbnailView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: pdfThumbnailView.trailingAnchor).isActive = true
        pdfThumbnailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfThumbnailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfThumbnailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pdfThumbnailView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.autoScales = true
    }
    
}
