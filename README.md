## Usage

```swift
import dataGenerator

print("Cartão: " + dataGenerator.creditCard(for: .MasterCard,Masked: .Masked))
// => One random credcard number

let address = dataGenerator.addressComplete()

print("Cidade: \(String(describing: address["city"]!)), Bairro: \(String(describing: address["neighborhood"]!)), Rua: \(String(describing: address["street"]!)), Número: \(String(describing: address["number"]!)), CEP: \(String(describing: address["zipCode"]!))")
// => One random addressComplete ()

print("Data: " + dataGenerator.date(format: "dd/MM/yyyy hh:mm:ss", milisecond: 0))
// => One Date

print("Celular: " + dataGenerator.phone(Masked: .Masked, Cel: true, withDDD: true))
print("Telefone: " + dataGenerator.phone(Masked: .Masked, Cel: false, withDDD: false))
// => One Phone random

print("Senha: " + dataGenerator.password(for: .Alphanumeric,length: 10))
// => One Password random

print(dataGenerator.randomBool())
// => One Bool random valid

print("RG: " + dataGenerator.rg(Masked: .Masked))
// => One RG random valid

print("CPF: " + dataGenerator.cpf(Masked: .Masked))
// => One CPF random valid

print("CNPJ: " + dataGenerator.cnpj(Masked: .Masked))
// => One CPNJ random

print("CEP: " + dataGenerator.zipCode(Masked: .Masked))
// => One CEP random

print("PLACA DE CARRO: " + dataGenerator.carPlate(Masked: .Masked))
// => One Car Plate random

print("PALAVRA: " + dataGenerator.word)
// => One random word

print("PALAVRAS: " + dataGenerator.words(3))
// => Three random words

print("SENTENÇA: " + dataGenerator.sentence)
// => One random sentence

print("SENTENÇAS: " + dataGenerator.sentences(3))
// => Three random sentences

print("PARAGRAFO: " + dataGenerator.paragraph)
// => One random paragraph

print("PARAGRAFOS: " + dataGenerator.paragraphs(3))
// => Three random paragraphs

print("TÍTULO: " + dataGenerator.title)
// => A random title

print("PRIMEIRO NOME: " + dataGenerator.firstName)
// => A random first name

print("ÚLTIMO NOME: " + dataGenerator.lastName)
// => A random last name

print("NOME COMPLETO: " + dataGenerator.fullName)
// => A random full name

print("E-MAIL: " + dataGenerator.emailAddress)
// => A random email address

print("URL: " + dataGenerator.url)
// => A random URL

print("TWEET 140: " + dataGenerator.shortTweet)
// => A random short tweet

print("TWEET 280: " + dataGenerator.tweet)
// => A random long tweet
```

## Author

Eduardo dos santos

Credits also
Lukas Kubanek // [lukaskubanek.com](http://lukaskubanek.com) // [@kubanekl](https://twitter.com/kubanekl)
https://github.com/lukaskubanek/LoremSwiftum/blob/master/README.md

## License

**dataGenerator** is released under the [MIT License](LICENSE.md).
