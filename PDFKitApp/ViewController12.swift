//
//  ViewController12.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 11/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController12: UIViewController {
    
    let pdfView = PDFView()
    let pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "Document2", withExtension: "pdf")!)!
    var imageView: UIImageView?
    
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
        
        let thumbnailhButton = UIBarButtonItem(title: "Thumbnail", style: .plain, target: self, action: #selector(pageThumbnail(_:)))
        let hideButton = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(hide(_:)))
        navigationItem.rightBarButtonItems = [thumbnailhButton, hideButton]
    }
    
    @objc func pageThumbnail(_ sender: UIBarButtonItem) {
        self.imageView?.removeFromSuperview()

        guard let page = pdfView.currentPage else { return }
        let size = CGSize(width: 300, height: 300)
        let image = page.thumbnail(of: size, for: .artBox)

        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.imageView = imageView
    }
    
    @objc func hide(_ sender: UIBarButtonItem) {
        imageView?.removeFromSuperview()
    }
    
}
