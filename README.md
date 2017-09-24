# Introduction

The PathLiteral component is intended to assign a value to a Strings and Integers path. Its purpose is to create a dictionary of several keys of type String and Int associated with a value of type String, Int, Double and Bool.

# Example

```swift
let dic = PathLiteral()
dic["a", "b"] = 5
dic["a", "b", "c"] = "abc"
dic["a", "b", "c", 0] = "123"
dic["a", 0, "b", 1] = "123"
```

# Rules

* Each path item can have values of type Int and String. Some rules exist for each item of this:
    * In case of type String, the values must be only texts with numeric characters and letters.
    * If text that has space is applied, the assignment will not be performed and the recovery will return null.

# Api

## Subscript

* Recupera e atribui um valor Literal baseado num conjunto de pais com pelo menos um elemento de Strings e Inteiros

```swift
subscript(first: IndexLiteral, others: IndexLiteral...) -> Literal? { get set }
```

## Funções

* Retorna a lista de filhos baseado no caminho

```swift
func list(_ parents: IndexLiteral...) -> [IndexLiteral]
```

* Retorna todos os valores do tipo String quando no caminho possui elementos de array

```swift
func strings(_ parents: IndexLiteral...) -> [String]
```

* Retorna todos os valores do tipo Int quando no caminho possui elementos de array

```swift
func ints(_ parents: IndexLiteral...) -> [Int]
```

* Retorna todos os valores do tipo Double quando no caminho possui elementos de array

```swift
func doubles(_ parents: IndexLiteral...) -> [Double] 
```

* Retorna todos os valores do tipo Bool quando no caminho possui elementos de array

```swift
func bools(_ parents: IndexLiteral...) -> [Bool]
```

* Retorna todos os elementos com seus caminhos e valores correspondentes

```swift
func entrys() -> [(path: String, value: Literal)]
```

## Protocolo CustomStringConvertible

```swift
var description: String
var debugDescription: String
```




