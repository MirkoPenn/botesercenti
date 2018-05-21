//
//  DocumentComposer.swift
//  BOTesercenti
//
//  Created by Simone Penna on 21/05/18.
//  Copyright © 2018 spark-ios-sdk. All rights reserved.

import UIKit
import PDFKit

class DocumentComposer: NSObject {
    
    let pathToMercatoHTMLTemplate = Bundle.main.path(forResource: "progetto-a-mercato", ofType: "html")
    
    let pathToFinanziarioHTMLTemplate = Bundle.main.path(forResource: "progetto-finanziario", ofType: "html")
    
    override init() {
        super.init()
    }
    
    func renderHTML1() -> String! {
        do {
            var htmlContent = try String(contentsOfFile: pathToMercatoHTMLTemplate!)
            //replace all occurrencies
            
            htmlContent = htmlContent.replacingOccurrences(of: "#RIUNIONE-1#", with: "21 Aprile 2018")
            htmlContent = htmlContent.replacingOccurrences(of: "#RIUNIONE0#", with: "Francesco Falaschi")
            htmlContent = htmlContent.replacingOccurrences(of: "#ESITI_ANALISI1#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#SPUNTATIPO2", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#SPUNTATIPO3#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#ENTE4#", with: "VarGroup")
            htmlContent = htmlContent.replacingOccurrences(of: "#SCADENZA5#", with: "6 Giugno 2018")
            htmlContent = htmlContent.replacingOccurrences(of: "#MISURA6#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#TITOLO7#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "ACRONIMO8#", with: "ACR")
            htmlContent = htmlContent.replacingOccurrences(of: "#PROFILO9#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#GESTIONESPUNTA10#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#GESTIONESPUNTA11#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#PARTNER12#", with: "Cisco")
            htmlContent = htmlContent.replacingOccurrences(of: "#FINANZIAMENTO13#", with: "10.000")
            htmlContent = htmlContent.replacingOccurrences(of: "#COFINANZIAMENTO14#", with: "5.000")
            htmlContent = htmlContent.replacingOccurrences(of: "#ORE15#", with: "125")
            htmlContent = htmlContent.replacingOccurrences(of: "#ORESTAGE16#", with: "250")
            htmlContent = htmlContent.replacingOccurrences(of: "#TIPO17#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#DURATA18#", with: "6")
            htmlContent = htmlContent.replacingOccurrences(of: "#NUMERO19#", with: "100")
            htmlContent = htmlContent.replacingOccurrences(of: "#INIZIO20#", with: "3 Maggio 2018")
            htmlContent = htmlContent.replacingOccurrences(of: "#ESITO21#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE22#", with: "Specifiche del progetto da rielaborare.")
            htmlContent = htmlContent.replacingOccurrences(of: "#PROGETTO23#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#PROGETTO24#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#SPECIFICHE25#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#DATA#", with: "21/05/1995")
            htmlContent = htmlContent.replacingOccurrences(of: "#RISORSEINTERNE27#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#RISORSEESTERNE28#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#DEFINIZIONE29#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#DOTAZIONE30#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#ARTICOLAZIONE31#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#ESITO32#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE33#", with: "Progetto da presentare. Completo.")
            htmlContent = htmlContent.replacingOccurrences(of: "#PRESENTARE34#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#NONPRESENTARE35#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#SPECIFICHE36#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#AMMISSIBILE38#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#NONAMMISSIBILE39#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE41#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#AEP42#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#ANP43#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NP44#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE46#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#ATTIVITA47#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#MATRICOLA48#", with: "N3346435345")
            htmlContent = htmlContent.replacingOccurrences(of: "#POSITIVO49#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#NEGATIVO50#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE52#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#INCARICATO53#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#TEMPI54#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#AFFISSIONI55#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#PUBB56#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#LOCANDINE57#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#SPORTELLO58#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#ALTRO59#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#POSITIVO60#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#NEGATIVO61#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE62#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#PUBBLICITA63#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#PUBBLICITA64#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE65#", with: "")
            // The HTML code is ready.
            return htmlContent
            
        } catch {
            print("Unable to open and use HTML template files.")
        }
        return nil
    }
    
    func renderHTML2() -> String! {
        do {
            var htmlContent = try String(contentsOfFile: pathToFinanziarioHTMLTemplate!)
            //replace all occurrencies
            
            htmlContent = htmlContent.replacingOccurrences(of: "#ANNO1#", with: "2001")
            htmlContent = htmlContent.replacingOccurrences(of: "#TITOLO2#", with: "Gianni Rossi")
            htmlContent = htmlContent.replacingOccurrences(of:"#PROFILO4#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#OBIETTIVI5#", with: "ingegnere")
            htmlContent = htmlContent.replacingOccurrences(of: "#DEST6#", with: "comune Bologna")
            htmlContent = htmlContent.replacingOccurrences(of: "#CONTENUTI7#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#DOCENTI8#", with: "Simona Renna")
            htmlContent = htmlContent.replacingOccurrences(of: "#TEMPI10#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#AFFISSIONI11#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#PUBBLICAZIONI12#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#LOCANDINE13#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#SPORTELLO14#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#ALTRO15#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#LOCALI16#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#AULA18#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#VIDEO19#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#AULA20#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#LAVAGNA21#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#LAB22#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#LAVAGNA23#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#ALTRO24#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#ALTRO25#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#CONSUMO26#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#DISPENSE28#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#CARTELLINE29#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#ALTRO30#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#METODI31#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#METODI32#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#METODI33#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#FREQUENZA34#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#QUALIFICA35#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#SPEC36#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#PERF37#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#PRODMAT38", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#COSTI39#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE40#", with: "2414")
            htmlContent = htmlContent.replacingOccurrences(of: "#ESITO41#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE42#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#PROG43#", with: "X")
            htmlContent = htmlContent.replacingOccurrences(of: "#PROG44# ", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#PROG45#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE46#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#ESITO47#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE48#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#PROG49# ", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#PROG50# ", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#PROG51#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#APPROVATO52#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#APPROVATO53#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE54#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#POSITIVO55#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NEGATIVO56#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#NOTE57#", with: "")
            htmlContent = htmlContent.replacingOccurrences(of: "#DATA#", with: "21/05/2018")
            
            // The HTML code is ready.
            return htmlContent
            
        } catch {
            print("Unable to open and use HTML template files.")
        }
        return nil
    }
    
    //    func renderInvoice(invoiceNumber: String, invoiceDate: String, itemsA: [[String: String]], itemsS: [[String: String]]) -> String! {
    //
    //        do {
    //            // Load the invoice HTML template code into a String variable.
    //            var HTMLContent = try String(contentsOfFile: pathToMercatoHTMLTemplate!)
    //
    //            // Replace all the placeholders with real values except for the items.
    //            // The logo image.
    //           "#LOGO_IMAGE#", with: logoImageURL)
    //
    //            // Invoice number.
    //           "#INVOICE_NUMBER#", with: invoiceNumber)
    //
    //            // Invoice date.
    //           "#INVOICE_DATE#", with: invoiceDate)
    //
    //            // Due date (we leave it blank by default).
    //           "#DUE_DATE#", with: dueDate)
    //
    //            // Sender info.
    //           "#SENDER_INFO#", with: senderInfo)
    //
    //           "#ACTIVE#", with: NSLocalizedString("Active Prescriptions (Quantity)", comment: "")
    //
    //           "#SUSPENDED#", with: NSLocalizedString("Suspended Prescriptions (Quantity)", comment: "")
    //
    //           "#FREQUENCY#", with: NSLocalizedString("Frequency", comment: "")
    //
    //           "#DATE#", with: NSLocalizedString("Date", comment: "")
    //
    //           "#START#", with: NSLocalizedString("Start", comment: "")
    //
    //           "#END#", with: NSLocalizedString("End", comment: "")
    //            // The invoice items will be added by using a loop.
    //            var itemsActivated = ""
    //
    //            // For all the items except for the last one we'll use the "single_item.html" template.
    //            // For the last one we'll use the "last_item.html" template.
    //            for i in 0..<itemsA.count {
    //                var itemHTMLContent: String!
    //
    //                // Determine the proper template file.
    //                if i != itemsA.count - 1 {
    //                    itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
    //                } else {
    //                    itemHTMLContent = try String(contentsOfFile: pathToLastItemHTMLTemplate!)
    //                }
    //
    //                // Replace the description and price placeholders with the actual values.
    //                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_DESC#", with: itemsA[i]["item"]!)
    //
    //                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#FREQUENCY#", with: itemsA[i]["frequency"]!)
    //
    //                // Format each item's price as a currency value.
    ////                let formattedPrice = AppDelegate.getAppDelegate().getStringValueFormattedAsCurrency(value: items[i]["price"]!)
    //                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#STARTDATE#", with: itemsA[i]["startdate"]!)
    //
    //                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ENDDATE#", with: itemsA[i]["enddate"]!)
    //
    //                // Add the item's HTML code to the general items string.
    //                itemsActivated += itemHTMLContent
    //            }
    //
    //            // Set the items.
    //           "#ITEMSACTIVATED#", with: itemsActivated)
    //
    //            var itemsSuspended = ""
    //            for i in 0..<itemsS.count {
    //                var itemHTMLContent: String!
    //
    //                // Determine the proper template file.
    //                if i != itemsS.count - 1 {
    //                    itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
    //                } else {
    //                    itemHTMLContent = try String(contentsOfFile: pathToLastItemHTMLTemplate!)
    //                }
    //
    //                // Replace the description and price placeholders with the actual values.
    //                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_DESC#", with: itemsS[i]["item"]!)
    //
    //                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#FREQUENCY#", with: itemsS[i]["frequency"]!)
    //
    //                // Format each item's price as a currency value.
    //                //                let formattedPrice = AppDelegate.getAppDelegate().getStringValueFormattedAsCurrency(value: items[i]["price"]!)
    //                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#STARTDATE#", with: itemsA[i]["startdate"]!)
    //
    //                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ENDDATE#", with: itemsA[i]["enddate"]!)
    //
    //                // Add the item's HTML code to the general items string.
    //                itemsSuspended += itemHTMLContent
    //            }
    //
    //            // Set the items.
    //           "#ITEMSSUSPENDED#", with: itemsSuspended)
    //
    //            // The HTML code is ready.
    //            return HTMLContent
    //
    //        } catch {
    //            print("Unable to open and use HTML template files.")
    //        }
    //        return nil
    //    }
    //
    //    func exportHTMLContentToPDF(HTMLContent: String) -> NSData! {
    //        let printPageRenderer = CustomPrintPageRenderer()
    //
    //        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
    //        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
    //
    //        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
    //
    ////        pdfFilename = "Pet Therapy.pdf"
    //        pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir()/PetTherapy.pdf"
    //        pdfData?.write(toFile: pdfFilename, atomically: true)
    //
    //        print(pdfFilename)
    //
    //        return pdfData
    //    }
    //
    //    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
    //        let data = NSMutableData()
    //
    //        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
    //        for i in 0..<printPageRenderer.numberOfPages {
    //            UIGraphicsBeginPDFPage()
    //            printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds()
    //        }
    //
    //        UIGraphicsEndPDFContext()s
    //
    //        return data
    //    }
    
}
