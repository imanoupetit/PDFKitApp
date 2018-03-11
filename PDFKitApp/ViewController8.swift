//
//  ViewController8.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 09/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController8: UIViewController {
    
    var gestureStartingPoint = CGPoint()
    var gestureStartingCenter = CGPoint()
    
    let pdfView = PDFView()
    let pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "Document2", withExtension: "pdf")!)!
    
    let currentAnnotation: PDFAnnotation = {
        let annotation = PDFAnnotation(bounds: .zero, forType: .square, withProperties: nil)
        annotation.color = .red
        let border = PDFBorder()
        border.lineWidth = 2
        annotation.border = border
        return annotation
    }()
    
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
        
        let moveButton = UIBarButtonItem(title: "Move", style: .plain, target: self, action: #selector(move(_:)))
        navigationItem.rightBarButtonItem = moveButton
        
        let initialBounds = CGRect(x: 10, y: 10, width: 100, height: 100)
        currentAnnotation.bounds = initialBounds
        pdfDocument.page(at: 0)!.addAnnotation(currentAnnotation)
        
        if let docView = pdfView.documentView {
            print(docView)
        }
        
        let swipeGesture = UITapGestureRecognizer(target: self, action: #selector(move(_:)))
        pdfView.addGestureRecognizer(swipeGesture)
        
        let tapGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        pdfView.addGestureRecognizer(tapGesture)
    }

    override func viewWillLayoutSubviews() {
        pdfView.autoScales = true
    }
    
    @objc func move(_ sender: UIBarButtonItem) {
        currentAnnotation.bounds.origin.x += 10
        currentAnnotation.bounds.origin.y += 10
    }
    
    @objc func pan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            gestureStartingPoint = sender.location(in: pdfView)
            gestureStartingCenter = pdfView.convert(CGPoint(x: currentAnnotation.bounds.midX, y: currentAnnotation.bounds.midX), from: pdfView.currentPage!)
        case .changed:
            let currentPoint = sender.location(in: pdfView)
            let distanceX = currentPoint.x - gestureStartingPoint.x
            let distanceY = currentPoint.y - gestureStartingPoint.y
            let newCenter = CGPoint(x: gestureStartingCenter.x + distanceX, y: gestureStartingCenter.y + distanceY)
            //badgeView.center = newCenter
            //currentAnnotation.bounds
            currentAnnotation.bounds.origin = newCenter
        case .ended:
            gestureStartingPoint = .zero
            gestureStartingCenter = .zero
        default:
            break
        }
    }
    
}
