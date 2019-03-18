//
//  example.swift
//  dataGenerator
//
//  Created by Eduardo dos santos on 17/03/19.
//  Copyright © 2019 Eduardo dos santos. All rights reserved.
//

import Foundation
import dataGenerator

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //One Credcard number MasterCard
        print("Credcard Number: " + dataGenerator.creditCard(for: .MasterCard, Masked: .Masked))
        
        //One Random Address complete
        let address = dataGenerator.addressComplete()
        print("City: \(String(describing: address["city"]!)), Neighborhood: \(String(describing: address["neighborhood"]!)), Street: \(String(describing: address["street"]!)), Number: \(String(describing: address["number"]!)), ZipCode: \(String(describing: address["zipCode"]!))")
        
        //One formatted date
        print("Date: " + dataGenerator.date(format: "dd/MM/yyyy hh:mm:ss", milisecond: 0))

        //One Cell phone and Phone with mask
        print("Cellphone: " + dataGenerator.phone(Masked: .Masked, Phone: .Cellphone, withDDD: .WithDDD))
        print("Phone: " + dataGenerator.phone(Masked: .Masked, Phone: .Phone, withDDD: .WithDDD))
        
        // => One random password
        print("Password: " + dataGenerator.password(for: .Alphanumeric,length: 10))
        
        // => One random Boolean
        print(dataGenerator.randomBool())
        
        // => One random RG
        print("RG: " + dataGenerator.rg(Masked: .Masked))
        
        // => One random CPF valid
        print("CPF: " + dataGenerator.cpf(Masked: .Masked))
        
        // => One random CPNJ
        print("CNPJ: " + dataGenerator.cnpj(Masked: .Masked))
        
        // => One random ZipCode BR (CEP)
        print("ZipCode BR: " + dataGenerator.zipCode(Masked: .Masked))
        
        // => One random Car Plate
        print("Car Plate: " + dataGenerator.carPlate(Masked: .Masked))
        
        // => One word random
        print("Word: " + dataGenerator.word)
        
        // => Three words random
        print("Words: " + dataGenerator.words(3))
        
        // => One sentence random
        print("Sentence: " + dataGenerator.sentence)
        
        // => Three sentences random
        print("Sentences: " + dataGenerator.sentences(3))
        
        // => One paragraph random
        print("Paragraph: " + dataGenerator.paragraph)
        
        // => Three paragraphs random
        print("Paragraphs: " + dataGenerator.paragraphs(3))
        
        // => A title random
        print("Title: " + dataGenerator.title)
        
        // => A first name random
        print("First name: " + dataGenerator.firstName)
        
        // => A last name random
        print("Last name: " + dataGenerator.lastName)
        
        // => A full name random
        print("Full name: " + dataGenerator.fullName)
        
        // => A email address random
        print("E-MAIL: " + dataGenerator.emailAddress)
        
        // => A URL random
        print("URL: " + dataGenerator.url)
        
        // => A short tweet random
        print("TWEET 140: " + dataGenerator.shortTweet)
        
        // => A long tweet random
        print("TWEET 280: " + dataGenerator.tweet)
        
    }
    
}

