//
//  dataGenerator.swift
//  dataGenerator
//
//  Created by Eduardo dos santos on 16/03/19.
//  Copyright © 2019 Eduardo dos santos. All rights reserved.
//

import Foundation

public final class dataGenerator {
    
    // ======================================================= //
    // MARK: - Documents for register
    // ======================================================= //
    

    /// Generates one Phone or CellPhone, With DDD and/or Mask optional
    ///
    /// - Parameter Masked: With mask? / Phone: Cellphone ou Phone? / withDDD: With DDD?.
    /// - Returns: Random Telefone/Cellfone with or without mask
    public class func phone(Masked: MaskedType, Phone: PhoneType, withDDD: PhoneType) -> String {
        
        var phone = ""
        
        if(withDDD == .WithDDD){
            if(Masked == .Masked){
                phone = "(\(arc4random_uniform(9))\(arc4random_uniform(9))) "
            } else {
                phone = "\(arc4random_uniform(9))\(arc4random_uniform(9))"
            }
        }
        
        if(Phone == .Cellphone){
            phone += "9"
        }
        
        if(Masked == .Masked){
            phone += "\(arc4random_uniform(9))\(arc4random_uniform(9))\(arc4random_uniform(9))\(arc4random_uniform(9))-\(arc4random_uniform(9))\(arc4random_uniform(9))\(arc4random_uniform(9))\(arc4random_uniform(9))"
        } else {
            phone += "\(arc4random_uniform(9))\(arc4random_uniform(9))\(arc4random_uniform(9))\(arc4random_uniform(9))\(arc4random_uniform(9))\(arc4random_uniform(9))\(arc4random_uniform(9))\(arc4random_uniform(9))"
        }
        
        return phone
        
    }
    
    
    /// Generates an address complete
    public class func addressComplete() -> Dictionary<String,String> {
        
        let city_           = city.randomElement()!
        let neighborhood_   = neighborhood.randomElement()!
        let street_         = street.randomElement()!
        let number_         = (Int)(arc4random_uniform(1000))
        let zipCode_        = zipCode(Masked: .Masked)
        
        var addressDictionary: Dictionary = [String: String]()
        addressDictionary["city"]           = city_
        addressDictionary["neighborhood"]   = neighborhood_
        addressDictionary["street"]         = street_
        addressDictionary["number"]         = String(number_)
        addressDictionary["zipCode"]        = zipCode_
        
        return addressDictionary
        
    }
    
    
    /// Generates one Credcard number by flag
    ///
    /// - Parameter for: CreditCardType / Masked: With Mask?
    /// - Returns: Random Credcard with or without mask
    public class func creditCard(for type: CreditCardType, Masked: MaskedType) -> String{
        /* Obtain proper card length */
        var cardLength = (type == .Visa13Digit) ? 13 : 16
        cardLength = (type == .AmericanExpress) ? 15 : cardLength
        cardLength = (type == .DinersClubInternational || type == .DinersClubCarteBlanche) ? 14 : cardLength
        
        
        var cardNumber = [Int](repeating: 0, count: cardLength)
        var startingIndex = 0
        
        /* Conform to rules for beginning card numbers */
        if type == .Visa || type == .Visa13Digit {
            cardNumber[0] = 4
            startingIndex = 1
        }
        else if type == .MasterCard {
            cardNumber[0] = 5
            cardNumber[1] = Int(arc4random_uniform(5) + 1)
            startingIndex = 2
        }
        else if type == .Discover {
            cardNumber.replaceSubrange(Range(0...3), with: [6,0,1,1])
            startingIndex = 4
        }
        else if type == .AmericanExpress {
            cardNumber.replaceSubrange(Range(0...1), with: [3,4])
            startingIndex = 2
        }
        else if type == .DinersClubUSA || type == .DinersClubCanada {
            //Will most often pass as a master card because of the 54
            cardNumber.replaceSubrange(Range(0...1), with: [5,4])
            startingIndex = 2
        }
        else if type == .DinersClubInternational {
            cardNumber.replaceSubrange(Range(0...1), with: [3,6])
            startingIndex = 2
        }
        else if type == .DinersClubCarteBlanche {
            cardNumber.replaceSubrange(Range(0...2), with: [3,0,0])
            startingIndex = 3
        }
        else if type == .JCB {
            cardNumber.replaceSubrange(Range(0...3), with: [3,5,2,8])
            startingIndex = 4
        }
        
        
        /* Fill array with random numbers 0-9 */
        for i in startingIndex..<cardNumber.count{
            cardNumber[i] = Int(arc4random_uniform(10))
        }
        
        /* Calculate the final digit using a custom variation of Luhn's formula
         This way we dont have to spend time reversing the array
         */
        let offset = (cardNumber.count+1)%2
        var sum = 0
        for i in 0..<cardNumber.count-1 {
            if ((i+offset) % 2) == 1 {
                var temp = cardNumber[i] * 2
                if temp > 9{
                    temp -= 9
                }
                sum += temp
            }
            else{
                sum += cardNumber[i]
            }
        }
        let finalDigit = (10 - (sum % 10)) % 10
        cardNumber[cardNumber.count-1] = finalDigit
        
        if(Masked == .Masked){
            return "\(cardNumber[0])\(cardNumber[1])\(cardNumber[2])\(cardNumber[3]).\(cardNumber[4])\(cardNumber[5])\(cardNumber[6])\(cardNumber[7]).\(cardNumber[8])\(cardNumber[9])\(cardNumber[10])\(cardNumber[11]).\(cardNumber[12])\(cardNumber[13])\(cardNumber[14])\(cardNumber[15])"
        } else {
            return "\(cardNumber[0])\(cardNumber[1])\(cardNumber[2])\(cardNumber[3])\(cardNumber[4])\(cardNumber[5])\(cardNumber[6])\(cardNumber[7])\(cardNumber[8])\(cardNumber[9])\(cardNumber[10])\(cardNumber[11])\(cardNumber[12])\(cardNumber[13])\(cardNumber[14])\(cardNumber[15])"
        }
    }
    
    
    /// Generates one Date
    ///
    /// - Parameter format: Formatter Ex. "dd/MM/yyyy hh:mm:ss" / milisecond: Miliseconds to convert
    /// - Returns: Date formatted
    public class func date(format: String, milisecond: Int) -> String {
        
        var milisecond_ = 0
        if milisecond == 0 {
            milisecond_ = Int(Date.timeIntervalSinceReferenceDate.rounded())
        }
        
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond_)/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: dateVar)
        
    }
    
    
    /// Generates a boolean value
    public class func randomBool() -> Bool {
        
        let booleans = [true,false]
        return booleans.randomElement()!
        
    }
    
    /// Generates one RG random
    ///
    /// - Parameter Masked: With Mask?
    /// - Returns: Random RG with or without mask
    public class func rg(Masked: MaskedType) -> String {
        
        var rg = [0,0,0,0,0,0,0,0,""] as [Any]
        
        for i in 0...8 {
            if(i == 8){
                if(randomBool()){
                    rg[i] = "X"
                } else {
                    rg[i] = (Int)(arc4random_uniform(9))
                }
            } else {
                rg[i] = (Int)(arc4random_uniform(9))
            }
        }
        
        if(Masked == .Masked){
            return "\(rg[0])\(rg[1]).\(rg[2])\(rg[3])\(rg[4]).\(rg[5])\(rg[6])\(rg[7])-\(rg[8])"
        } else {
            return "\(rg[0])\(rg[1])\(rg[2])\(rg[3])\(rg[4])\(rg[5])\(rg[6])\(rg[7])\(rg[8])"
        }
        
    }
    
    /// Generates one Password random
    ///
    /// - Parameter for: Hashtype, ex. only number / length: the length of string
    /// - Returns: Random Password with or without mask

    public class func password(for type: HashType,length: Int) -> String {
        if(type == .Alphabetic){
            return String((0..<length).map{ _ in letters.randomElement()!})
        } else if (type == .Numbers) {
            return String((0..<length).map{ _ in numbers.randomElement()!})
        } else {
            return String((0..<length).map{ _ in characters.randomElement()!})
        }
    }
    
    
    /// Generates one CPF valid random
    ///
    /// - Parameter Masked: With Mask?
    /// - Returns: Random CPF valid with or without mask
    public class func cpf(Masked: MaskedType) -> String {
        
        var cpf = [0,0,0,0,0,0,0,0,0,0,0]
        var temp1 = 0,temp2 = 0
        
        for i in 0...8 {
            cpf[i] = (Int)(arc4random_uniform(9))
            temp1 += cpf[i] * (10 - i)
            temp2 += cpf[i] * (11 - i)
        }
        
        temp1 %= 11
        cpf[9] = temp1 < 2 ? 0 : 11-temp1
        
        temp2 += cpf[9] * 2
        temp2 %= 11
        cpf[10] = temp2 < 2 ? 0 : 11-temp2
        
        if(Masked == .Masked){
            
            return "\(cpf[0])\(cpf[1])\(cpf[2]).\(cpf[3])\(cpf[4])\(cpf[5]).\(cpf[6])\(cpf[7])\(cpf[8])-\(cpf[9])\(cpf[10])"
            
        } else {
            
            return "\(cpf[0])\(cpf[1])\(cpf[2])\(cpf[3])\(cpf[4])\(cpf[5])\(cpf[6])\(cpf[7])\(cpf[8])\(cpf[9])\(cpf[10])"
            
        }
        
    }
    
    /// Generates one CNPJ random
    ///
    /// - Parameter Masked: With Mask?
    /// - Returns: Random CNPJ with or without mask
    public class func cnpj(Masked: MaskedType) -> String {
        
        var cnpj = [0,0,0,0,0,0,0,0,0,0,0,1,0,0]
        var temp1 = 2, temp2 = 3
        var baseDig1 = 5, baseDig2 = 6
        
        for i in 0...7 {
            cnpj[i] = (Int)(arc4random_uniform(9))
            temp1 += cnpj[i] * baseDig1
            temp2 += cnpj[i] * baseDig2
            
            baseDig1 = baseDig1 == 2 ? 9 : baseDig1-1
            baseDig2 = baseDig2 == 2 ? 9 : baseDig2-1
        }
        
        temp1 %= 11
        cnpj[12] = temp1 < 2 ? 0 : 11-temp1
        
        temp2 += cnpj[9] * 2
        temp2 %= 11
        cnpj[13] = temp2 < 2 ? 0 : 11-temp2
        
        if(Masked == .Masked){
            
            return "\(cnpj[0])\(cnpj[1]).\(cnpj[2])\(cnpj[3])\(cnpj[4]).\(cnpj[5])\(cnpj[6])\(cnpj[7])/\(cnpj[8])\(cnpj[9])\(cnpj[10])\(cnpj[11])-\(cnpj[12])\(cnpj[13])"
            
        } else {
            
            return "\(cnpj[0])\(cnpj[1])\(cnpj[2])\(cnpj[3])\(cnpj[4])\(cnpj[5])\(cnpj[6])\(cnpj[7])\(cnpj[8])\(cnpj[9])\(cnpj[10])\(cnpj[11])\(cnpj[12])\(cnpj[13])"
            
        }
        
    }
    
    /// Generates one ZipCode random
    ///
    /// - Parameter Masked: With Mask?
    /// - Returns: Random ZipCode with or without mask
    public class func zipCode(Masked: MaskedType) -> String {
        
        var zipCode = [0,0,0,0,0,0,0,0]
        
        for i in 0...7 {
            zipCode[i] = (Int)(arc4random_uniform(9))
        }
        
        if(Masked == .Masked){
            return "\(zipCode[0])\(zipCode[1])\(zipCode[2])\(zipCode[3])\(zipCode[4])-\(zipCode[5])\(zipCode[6])\(zipCode[7])"
        } else {
            return "\(zipCode[0])\(zipCode[1])\(zipCode[2])\(zipCode[3])\(zipCode[4])\(zipCode[5])\(zipCode[6])\(zipCode[7])"
        }
        
    }
    
    /// Generates one Car plate random
    ///
    /// - Parameter Masked: With Mask?
    /// - Returns: Random Car Plate with or without mask
    public class func carPlate(Masked: MaskedType) -> String {
        
        var carPlate = ["","","",0,0,0,0] as [Any]
        
        for i in 0...6 {
            if(i < 3){
                carPlate[i] = letters.randomElement()!
            } else {
                carPlate[i] = (Int)(arc4random_uniform(9))
            }
        }
        
        if(Masked == .Masked){
            return "\(carPlate[0])\(carPlate[1])\(carPlate[2])-\(carPlate[3])\(carPlate[4])\(carPlate[5])\(carPlate[6])"
        } else {
            return "\(carPlate[0])\(carPlate[1])\(carPlate[2])\(carPlate[3])\(carPlate[4])\(carPlate[5])\(carPlate[6])"
        }
        
    }
    
    /// Generates a single word.
    public static var word: String {
        return allWords.randomElement()!
    }
    
    /// Generates multiple words whose count is defined by the given value.
    ///
    /// - Parameter count: The number of words to generate.
    /// - Returns: The generated words joined by a space character.
    public static func words(_ count: Int) -> String {
        return _compose(
            word,
            count: count,
            joinBy: .space
        )
    }
    
    /// Generates multiple words whose count is randomly selected from within the given range.
    ///
    /// - Parameter range: The range of number of words to generate.
    /// - Returns: The generated words joined by a space character.
    public static func words(_ range: Range<Int>) -> String {
        return _compose(word, count: Int.random(in: range), joinBy: .space)
    }
    
    /// Generates multiple words whose count is randomly selected from within the given closed range.
    ///
    /// - Parameter range: The range of number of words to generate.
    /// - Returns: The generated words joined by a space character.
    public static func words(_ range: ClosedRange<Int>) -> String {
        return _compose(word, count: Int.random(in: range), joinBy: .space)
    }
    
    /// Generates a single sentence.
    public static var sentence: String {
        let numberOfWords = Int.random(
            in: minWordsCountInSentence...maxWordsCountInSentence
        )
        
        return _compose(
            word,
            count: numberOfWords,
            joinBy: .space,
            endWith: .dot,
            decorate: { $0.firstLetterCapitalized }
        )
    }
    
    /// Generates multiple sentences whose count is defined by the given value.
    ///
    /// - Parameter count: The number of sentences to generate.
    /// - Returns: The generated sentences joined by a space character.
    public static func sentences(_ count: Int) -> String {
        return _compose(
            sentence,
            count: count,
            joinBy: .space
        )
    }
    
    /// Generates multiple sentences whose count is selected from within the given range.
    ///
    /// - Parameter count: The number of sentences to generate.
    /// - Returns: The generated sentences joined by a space character.
    public static func sentences(_ range: Range<Int>) -> String {
        return _compose(sentence, count: Int.random(in: range), joinBy: .space)
    }
    
    /// Generates multiple sentences whose count is selected from within the given closed range.
    ///
    /// - Parameter count: The number of sentences to generate.
    /// - Returns: The generated sentences joined by a space character.
    public static func sentences(_ range: ClosedRange<Int>) -> String {
        return _compose(sentence, count: Int.random(in: range), joinBy: .space)
    }
    
    /// Generates a single paragraph.
    public static var paragraph: String {
        let numberOfSentences = Int.random(
            in: minSentencesCountInParagraph...maxSentencesCountInParagraph
        )
        
        return _compose(
            sentence,
            count: numberOfSentences,
            joinBy: .space
        )
    }
    
    /// Generates multiple paragraphs whose count is defined by the given value.
    ///
    /// - Parameter count: The number of paragraphs to generate.
    /// - Returns: The generated paragraphs joined by a new line character.
    public static func paragraphs(_ count: Int) -> String {
        return _compose(
            paragraph,
            count: count,
            joinBy: .newLine
        )
    }
    
    /// Generates multiple paragraphs whose count is selected from within the given range.
    ///
    /// - Parameter count: The number of paragraphs to generate.
    /// - Returns: The generated paragraphs joined by a new line character.
    public static func paragraphs(_ range: Range<Int>) -> String {
        return _compose(
            paragraph,
            count: Int.random(in: range),
            joinBy: .newLine
        )
    }
    
    /// Generates multiple paragraphs whose count is selected from within the given closed range.
    ///
    /// - Parameter count: The number of paragraphs to generate.
    /// - Returns: The generated paragraphs joined by a new line character.
    public static func paragraphs(_ range: ClosedRange<Int>) -> String {
        return _compose(
            paragraph,
            count: Int.random(in: range),
            joinBy: .newLine
        )
    }
    
    /// Generates a capitalized title.
    public static var title: String {
        let numberOfWords = Int.random(
            in: minWordsCountInTitle...maxWordsCountInTitle
        )
        
        return _compose(
            word,
            count: numberOfWords,
            joinBy: .space,
            decorate: { $0.capitalized }
        )
    }
    
    // ======================================================= //
    // MARK: - Names
    // ======================================================= //
    
    /// Generates a first name.
    public static var firstName: String {
        return firstNames.randomElement()!
    }
    
    /// Generates a last name.
    public static var lastName: String {
        return lastNames.randomElement()!
    }
    
    /// Generates a full name.
    public static var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    // ======================================================= //
    // MARK: - Email Addresses & URLs
    // ======================================================= //
    
    /// Generates an email address.
    public static var emailAddress: String {
        let emailDelimiter = emailDelimiters.randomElement()!
        let emailDomain = emailDomains.randomElement()!
        
        return "\(firstName)\(emailDelimiter)\(lastName)@\(emailDomain)".lowercased()
    }
    
    /// Generates a URL.
    public static var url: String {
        let urlScheme = urlSchemes.randomElement()!
        let urlDomain = urlDomains.randomElement()!
        return "\(urlScheme)://\(urlDomain)"
    }
    
    // ======================================================= //
    // MARK: - Tweets
    // ======================================================= //
    
    /// Generates a random tweet which is shorter than 140 characters.
    public static var shortTweet: String {
        return _composeTweet(shortTweetMaxLength)
    }
    
    /// Generates a random tweet which is shorter than 280 characters.
    public static var tweet: String {
        return _composeTweet(tweetMaxLength)
    }
    
}

fileprivate extension dataGenerator {
    
    fileprivate enum Separator: String {
        case none = ""
        case space = " "
        case dot = "."
        case newLine = "\n"
    }
    
    fileprivate static func _compose(
        _ provider: @autoclosure () -> String,
        count: Int,
        joinBy middleSeparator: Separator,
        endWith endSeparator: Separator = .none,
        decorate decorator: ((String) -> String)? = nil
        ) -> String {
        var string = ""
        
        for index in 0..<count {
            string += provider()
            
            if (index < count - 1) {
                string += middleSeparator.rawValue
            } else {
                string += endSeparator.rawValue
            }
        }
        
        if let decorator = decorator {
            string = decorator(string)
        }
        
        return string
    }
    
    fileprivate static func _composeTweet(_ maxLength: Int) -> String {
        for numberOfSentences in [4, 3, 2, 1] {
            let tweet = sentences(numberOfSentences)
            if tweet.count < maxLength {
                return tweet
            }
        }
        
        return ""
    }
    
    fileprivate static let minWordsCountInSentence = 4
    fileprivate static let maxWordsCountInSentence = 16
    fileprivate static let minSentencesCountInParagraph = 3
    fileprivate static let maxSentencesCountInParagraph = 9
    fileprivate static let minWordsCountInTitle = 2
    fileprivate static let maxWordsCountInTitle = 7
    fileprivate static let shortTweetMaxLength = 140
    fileprivate static let tweetMaxLength = 280
    
    fileprivate static let allWords = ["alias", "consequatur", "aut", "perferendis", "sit", "voluptatem", "accusantium", "doloremque", "aperiam", "eaque", "ipsa", "quae", "ab", "illo", "inventore", "veritatis", "et", "quasi", "architecto", "beatae", "vitae", "dicta", "sunt", "explicabo", "aspernatur", "aut", "odit", "aut", "fugit", "sed", "quia", "consequuntur", "magni", "dolores", "eos", "qui", "ratione", "voluptatem", "sequi", "nesciunt", "neque", "dolorem", "ipsum", "quia", "dolor", "sit", "amet", "consectetur", "adipisci", "velit", "sed", "quia", "non", "numquam", "eius", "modi", "tempora", "incidunt", "ut", "labore", "et", "dolore", "magnam", "aliquam", "quaerat", "voluptatem", "ut", "enim", "ad", "minima", "veniam", "quis", "nostrum", "exercitationem", "ullam", "corporis", "nemo", "enim", "ipsam", "voluptatem", "quia", "voluptas", "sit", "suscipit", "laboriosam", "nisi", "ut", "aliquid", "ex", "ea", "commodi", "consequatur", "quis", "autem", "vel", "eum", "iure", "reprehenderit", "qui", "in", "ea", "voluptate", "velit", "esse", "quam", "nihil", "molestiae", "et", "iusto", "odio", "dignissimos", "ducimus", "qui", "blanditiis", "praesentium", "laudantium", "totam", "rem", "voluptatum", "deleniti", "atque", "corrupti", "quos", "dolores", "et", "quas", "molestias", "excepturi", "sint", "occaecati", "cupiditate", "non", "provident", "sed", "ut", "perspiciatis", "unde", "omnis", "iste", "natus", "error", "similique", "sunt", "in", "culpa", "qui", "officia", "deserunt", "mollitia", "animi", "id", "est", "laborum", "et", "dolorum", "fuga", "et", "harum", "quidem", "rerum", "facilis", "est", "et", "expedita", "distinctio", "nam", "libero", "tempore", "cum", "soluta", "nobis", "est", "eligendi", "optio", "cumque", "nihil", "impedit", "quo", "porro", "Megamil", "Easter","quisquam", "est", "qui", "minus", "id", "quod", "maxime", "placeat", "facere", "possimus", "omnis", "voluptas", "assumenda", "est", "omnis", "dolor", "repellendus", "temporibus", "autem", "quibusdam", "et", "aut", "consequatur", "vel", "Egg", "illum", "qui", "dolorem", "eum", "fugiat", "quo", "voluptas", "nulla", "pariatur", "at", "vero", "eos", "et", "accusamus", "officiis", "debitis", "aut", "rerum", "necessitatibus", "saepe", "eveniet", "ut", "et", "voluptates", "repudiandae", "sint", "et", "molestiae", "non", "recusandae", "itaque", "earum", "rerum", "hic", "tenetur", "a", "sapiente", "delectus", "ut", "aut", "reiciendis", "voluptatibus", "maiores", "doloribus", "asperiores", "repellat"]
    
    fileprivate static let firstNames = ["Judith", "Angelo", "Margarita", "Kerry", "Elaine", "Lorenzo", "Justice", "Doris", "Raul", "Liliana", "Kerry", "Elise", "Ciaran", "Johnny", "Moses", "Davion", "Penny", "Mohammed", "Harvey", "Sheryl", "Hudson", "Brendan", "Brooklynn", "Denis", "Sadie", "Trisha", "Jacquelyn", "Virgil", "Cindy", "Alexa", "Marianne", "Giselle", "Casey", "Alondra", "Angela", "Katherine", "Skyler", "Kyleigh", "Carly", "Abel", "Adrianna", "Luis", "Dominick", "Eoin", "Noel", "Ciara", "Roberto", "Skylar", "Brock", "Earl", "Dwayne", "Jackie", "Hamish", "Sienna", "Nolan", "Daren", "Jean", "Shirley", "Connor", "Geraldine", "Niall", "Kristi", "Monty", "Yvonne", "Tammie", "Zachariah", "Fatima", "Ruby", "Nadia", "Anahi", "Calum", "Peggy", "Alfredo", "Marybeth", "Bonnie", "Gordon", "Cara", "John", "Staci", "Samuel", "Carmen", "Rylee", "Yehudi", "Colm", "Beth", "Dulce", "Darius", "inley", "Javon", "Jason", "Perla", "Wayne", "Laila", "Kaleigh", "Maggie", "Don", "Quinn", "Collin", "Aniya", "Zoe", "Isabel", "Clint", "Leland", "Esmeralda", "Emma", "Madeline", "Byron", "Courtney", "Vanessa", "Terry", "Antoinette", "George", "Constance", "Preston", "Rolando", "Caleb","Eduardo","Paulo","Ricardo","Oswaldo", "Rodrigo", "Felipe", "Link", "Goku", "Jiren", "Yugi", "Vegeta", "Megamil", "Antonio", "Maria", "Jaciara", "Ana", "Alexandra", "Jane", "Aline", "Bruna", "Kenneth", "Lynette", "Carley", "Francesca", "Johnnie", "Jordyn", "Arturo", "Camila", "Skye", "Guy", "Ana", "Kaylin", "Nia", "Colton", "Bart", "Brendon", "Alvin", "Daryl", "Dirk", "Mya", "Pete", "Joann", "Uriel", "Alonzo", "Agnes", "Chris", "Alyson", "Paola", "Dora", "Elias", "Allen", "Jackie", "Eric", "Bonita", "Kelvin", "Emiliano", "Ashton", "Kyra", "Kailey", "Sonja", "Alberto", "Ty", "Summer", "Brayden", "Lori", "Kelly", "Tomas", "Joey", "Billie", "Katie", "Stephanie", "Danielle", "Alexis", "Jamal", "Kieran", "Lucinda", "Eliza", "Allyson", "Melinda", "Alma", "Piper", "Deana", "Harriet", "Bryce", "Eli", "Jadyn", "Rogelio", "Orlaith", "Janet", "Randal", "Toby", "Carla", "Lorie", "Caitlyn", "Annika", "Isabelle", "inn", "Ewan", "Maisie", "Michelle", "Grady", "Ida", "Reid", "Emely", "Tricia", "Beau", "Reese", "Vance", "Dalton", "Lexi", "Rafael", "Makenzie", "Mitzi", "Clinton", "Xena", "Angelina", "Kendrick", "Leslie", "Teddy", "Jerald", "Noelle", "Neil", "Marsha", "Gayle", "Omar", "Abigail", "Alexandra", "Phil", "Andre", "Billy", "Brenden", "Bianca", "Jared", "Gretchen", "Patrick", "Antonio", "Josephine", "Kyla", "Manuel", "Freya", "Kellie", "Tonia", "Jamie", "Sydney", "Andres", "Ruben", "Harrison", "Hector", "Clyde", "Wendell", "Kaden", "Ian", "Tracy", "Cathleen", "Shawn"]
    
    fileprivate static let lastNames = ["Chung", "Chen", "Melton", "Hill", "Puckett", "Song", "Hamilton", "Bender", "Wagner", "McLaughlin", "McNamara", "Raynor", "Moon", "Woodard", "Desai", "Wallace", "Lawrence", "Griffin", "Dougherty", "Powers", "May", "Steele", "Teague", "Vick", "Gallagher", "Solomon", "Walsh", "Monroe", "Connolly", "Hawkins", "Middleton", "Goldstein", "Watts", "Johnston", "Weeks", "Wilkerson", "Barton", "Walton", "Hall", "Ross", "Chung", "Bender", "Woods", "Mangum", "Joseph", "Rosenthal", "Bowden", "Barton", "Underwood", "Jones", "Baker", "Merritt", "Cross", "Cooper", "Holmes", "Sharpe", "Morgan", "Hoyle", "Allen", "Rich", "Rich", "Grant", "Proctor", "Diaz", "Graham", "Watkins", "Hinton", "Marsh", "Hewitt", "Branch", "Walton", "O'Brien", "Case", "Watts", "Christensen", "Parks", "Hardin", "Lucas", "Eason", "Davidson", "Whitehead", "Rose", "Sparks", "Moore", "Pearson", "Rodgers", "Graves", "Scarborough", "Sutton", "Sinclair", "Bowman", "Olsen", "Love", "McLean", "Christian", "Lamb", "James", "Chandler", "Stout", "Cowan", "Golden", "Bowling", "Beasley", "Clapp", "Abrams", "Tilley", "Morse", "Boykin", "Sumner", "Cassidy", "Davidson", "Heath", "Blanchard", "McAllister", "McKenzie", "Byrne", "Schroeder", "Griffin", "Gross", "Perkins", "Robertson", "Palmer", "Brady", "Rowe", "Zhang", "Hodge", "Li", "Bowling", "Justice", "Glass","Santos", "Silva", "Pinto", "Teste", "Souza", "Marques", "Zaville", "Willis", "Hester", "Floyd", "Graves", "Fischer", "Norman", "Chan", "Hunt", "Byrd", "Lane", "Kaplan", "Heller", "May", "Jennings", "Hanna", "Locklear", "Holloway", "Jones", "Glover", "Vick", "O'Donnell", "Goldman", "McKenna", "Starr", "Stone", "McClure", "Watson", "Monroe", "Abbott", "Singer", "Hall", "Farrell", "Lucas", "Norman", "Atkins", "Monroe", "Robertson", "Sykes", "Reid", "Chandler", "Finch", "Hobbs", "Adkins", "Kinney", "Whitaker", "Alexander", "Conner", "Waters", "Becker", "Rollins", "Love", "Adkins", "Black", "Fox", "Hatcher", "Wu", "Lloyd", "Joyce", "Welch", "Matthews", "Chappell", "MacDonald", "Kane", "Butler", "Pickett", "Bowman", "Barton", "Kennedy", "Branch", "Thornton", "McNeill", "Weinstein", "Middleton", "Moss", "Lucas", "Rich", "Carlton", "Brady", "Schultz", "Nichols", "Harvey", "Stevenson", "Houston", "Dunn", "West", "O'Brien", "Barr", "Snyder", "Cain", "Heath", "Boswell", "Olsen", "Pittman", "Weiner", "Petersen", "Davis", "Coleman", "Terrell", "Norman", "Burch", "Weiner", "Parrott", "Henry", "Gray", "Chang", "McLean", "Eason", "Weeks", "Siegel", "Puckett", "Heath", "Hoyle", "Garrett", "Neal", "Baker", "Goldman", "Shaffer", "Choi", "Carver"]
    
    fileprivate static let emailDomains = ["gmail.com", "yahoo.com", "hotmail.com", "email.com", "live.com", "me.com", "mac.com", "aol.com", "fastmail.com", "mail.com", "megamil.net"]
    
    fileprivate static let urlDomains = ["twitter.com", "google.com", "youtube.com", "wordpress.org", "adobe.com", "blogspot.com", "godaddy.com", "wikipedia.org", "wordpress.com", "yahoo.com", "linkedin.com", "amazon.com", "flickr.com", "w3.org", "apple.com", "myspace.com", "tumblr.com", "digg.com", "microsoft.com", "vimeo.com", "pinterest.com", "stumbleupon.com", "youtu.be", "miibeian.gov.cn", "baidu.com", "feedburner.com", "bit.ly", "megamil.net"]
    
    fileprivate static let numbers = "0123456789"
    
    fileprivate static let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    fileprivate static let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&*_-+="
    
    fileprivate static let emailDelimiters = ["", ".", "-", "_"]
    
    fileprivate static let urlSchemes = ["http", "https"]
    
    fileprivate static let street = ["Av Paulista", "Tiradentes", "Maria Eliza", "Champs Elysees", "Las Vegas Strip", "Wall Street", "Via Dolorosa", "Khao San", "Orchard Road", "Lombard Street"]
    
    fileprivate static let neighborhood = ["Santos Dumont", "Bela Vista", "Moema", "Paraiso", "Jd Paulista", "Vila Mariana"]
    
    fileprivate static let city = ["Guarulhos", "São Paulo", "Santana", "Aruja", "Hyrule", "Lost Wood", "HILL ZONE", "Domino City"]
    
}

public enum CreditCardType{
    case Visa
    case Visa13Digit
    case MasterCard
    case Discover
    case AmericanExpress
    case DinersClubUSA
    case DinersClubCanada
    case DinersClubInternational
    case DinersClubCarteBlanche
    case JCB
}

public enum HashType{
    case Numbers
    case Alphabetic
    case Alphanumeric
}

public enum MaskedType{
    case Masked
    case Unmasked
}

public enum PhoneType{
    case Cellphone
    case Phone
    case WithDDD
    case WithOutDDD
}

fileprivate extension String {
    
    fileprivate var firstLetterCapitalized: String {
        guard !isEmpty else { return self }
        return prefix(1).capitalized + dropFirst()
    }
    
}
