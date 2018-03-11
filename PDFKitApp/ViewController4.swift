//
//  ViewController4.swift
//  PDFWatermarkApp
//
//  Created by Imanou on 08/03/2018.
//  Copyright © 2018 Imanou. All rights reserved.
//

import UIKit
import PDFKit

class ViewController4: UIViewController {
    
    let pdfView = PDFView()
    let pdfThumbnailView = PDFThumbnailView()
    let pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "Document2", withExtension: "pdf")!)!

    lazy var previousButton = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(previousTapped(_:)))
    lazy var nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped(_:)))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        pdfView.backgroundColor = .red
        pdfView.usePageViewController(true, withViewOptions: nil)
        pdfView.document = pdfDocument
        
        pdfThumbnailView.pdfView = pdfView
        pdfThumbnailView.layoutMode = .horizontal
        pdfThumbnailView.thumbnailSize = CGSize(width: 44, height: 44)
        pdfThumbnailView.backgroundColor = .groupTableViewBackground
        
        view.addSubview(pdfView)
        view.addSubview(pdfThumbnailView)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfThumbnailView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: pdfThumbnailView.bottomAnchor).isActive = true
        pdfThumbnailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfThumbnailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfThumbnailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pdfThumbnailView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        navigationItem.rightBarButtonItems = [nextButton, previousButton]
        toggleButons()

        NotificationCenter.default.addObserver(self, selector: #selector(handlePageChange(_:)), name: NSNotification.Name.PDFViewPageChanged, object: nil)
    }
    
    @objc func previousTapped(_ sender: UIBarButtonItem) {
        pdfView.goToPreviousPage(sender)
    }
    
    @objc func nextTapped(_ sender: UIBarButtonItem) {
        pdfView.goToNextPage(sender)
    }
    
    @objc func handlePageChange(_ notification: Notification) {
        toggleButons()
        
        guard
            let pdfView = notification.object as? PDFView,
            let currentPage = pdfView.currentPage
            else { print("Could not get page index"); return }
        print("User swiped to page: \(pdfDocument.index(for: currentPage) + 1) / \(pdfDocument.pageCount)")
    }
    
    func toggleButons() {
        previousButton.isEnabled = pdfView.canGoToPreviousPage()
        nextButton.isEnabled = pdfView.canGoToNextPage()
    }
    
    override func viewDidLayoutSubviews() {
        pdfView.autoScales = true
    }
    
}
