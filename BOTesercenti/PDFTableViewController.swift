//
//  PDFTableViewController.swift
//  Pdf
//
//  Created by Simone Penna on 20/05/2018.
//  Copyright © 2018 Simone Penna. All rights reserved.
//

import UIKit
import os.log
import PDFKit

class PDFTableViewController: UITableViewController {

//    var numberOfPdf: Int = 0
    var numberOfMonths: Int = 1
    var numberOfRowsInSection: [Int] = []
    var dateSet = Set<DateComponents>()
    var titleSectionSet = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pdfs = (UIApplication.shared.delegate as! AppDelegate).loadPDF()!
        numberOfRowsInSection = [pdfs.count]
        
        print(pdfs.first?.name)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfMonths
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows: Int = 0
        
        if section < numberOfRowsInSection.count {
            rows = numberOfRowsInSection[section]
        }
        
        return rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PdfTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PDFTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PdfTableViewCell.")
        }
        
        cell.documentImage.image = #imageLiteral(resourceName: "pdf")
        cell.documentTitle.text = pdfs[indexPath.row].name
        cell.data = pdfs[indexPath.row].data
        
        var detail = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
//        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: pdfs[indexPath.row].date)
        detail = "\(pdfs[indexPath.row].size) - \(dateFormatter.string(from: pdfs[indexPath.row].date))"
        cell.documentDetail.text = detail
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        return "Anno Mese"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var pdfData = (tableView.cellForRow(at: indexPath) as! PDFTableViewCell).data!
        
        var itemsToShare = [AnyHashable]()
        itemsToShare.append(pdfData)
        let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        self.present(controller, animated: true) {() -> Void in }
        
//
//        if let url =
//            {
//            UIApplication.shared.open(url)
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    private func loadSamplePDFS() {
        
        let date = Date()
        
//        guard let pdf1 = PDF(name: "pdf1.pdf", size: "2 MB", date: date) else {
//            fatalError("Unable to instantiate meal1")
//        }
//
//        guard let pdf2 = PDF(name: "pdf2.pdf", size: "10 MB", date: date) else {
//            fatalError("Unable to instantiate meal2")
//        }
//
//        guard let pdf3 = PDF(name: "pdf3.pdf", size: "247 KB", date: date) else {
//            fatalError("Unable to instantiate meal2")
//        }
//
//        pdfs += [pdf1, pdf2, pdf3]
        for pdf in pdfs {
            let component = Calendar.current.dateComponents([.year, .month], from: pdf.date)
            dateSet.insert(component)
            let month = giveMonth(month: component.month!)
            var sectionHeader = "\(String(describing: component.year!)) \(month)"
            titleSectionSet.insert(sectionHeader)
        }
        
        numberOfMonths = dateSet.count
        
    }
 
    


    func giveMonth(month: Int) -> String {
        var monthString = ""
        switch month {
        case 1:
            monthString = "Gennaio"
        case 2:
            monthString = "Febbraio"
        case 3:
            monthString = "Marzo"
        case 4:
            monthString = "Aprile"
        case 5:
            monthString = "Maggio"
        case 6:
            monthString = "Giugno"
        case 7:
            monthString = "Luglio"
        case 8:
            monthString = "Agosto"
        case 9:
            monthString = "Settembre"
        case 10:
            monthString = "Ottobre"
        case 11:
            monthString = "Novembre"
        case 12:
            monthString = "Dicembre"
        default:
            monthString = "Mese"
        }
        return monthString
        
        
    }

}
