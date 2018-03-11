//
//  ViewController1.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 08/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController1: UIViewController {

    let pdfView = PDFView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        guard
            let url = Bundle.main.url(forResource: "Document2", withExtension: "pdf"),
            let pdfDocument = PDFDocument(url: url)
            else { return }
        
        //pdfView.displayMode = .singlePageContinuous
        pdfView.usePageViewController(true, withViewOptions: nil)
        pdfView.document = pdfDocument
        view.addSubview(pdfView)

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true

        let moveButton = UIBarButtonItem(title: "Resize", style: .plain, target: self, action: #selector(resize(_:)))
        navigationItem.rightBarButtonItem = moveButton
    }
    
    override func viewWillLayoutSubviews() {
//        pdfView.autoScales = true
//        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
//        pdfView.maxScaleFactor = pdfView.scaleFactorForSizeToFit
//        pdfView.minScaleFactor = 0.1
//        pdfView.maxScaleFactor = 4.0
    }
    
    @objc func resize(_ sender: UIBarButtonItem?) {
        let animations: () -> Void = {
            self.pdfView.scaleFactor = self.pdfView.scaleFactorForSizeToFit
            self.view.layoutIfNeeded()
        }
        UIViewPropertyAnimator(duration: 3, curve: .linear, animations: animations).startAnimation()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            // Using `pdfView.autoScales = true` does the same job
            self.pdfView.scaleFactor = self.pdfView.scaleFactorForSizeToFit
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
