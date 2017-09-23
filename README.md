# Introdução

O componente PathLiteral tem como objetivo atribuir um valor a um caminho de Strings e Inteiros. Seu propósito é criar um dicionário de várias chaves do tipo String e Int associado a um valor do tipo String, Int, Double e Bool.

# Exemplo

```swift
let dic = PathLiteral()
dic["a", "b"] = 5
dic["a", "b", "c"] = "abc"
dic["a", "b", "c", 0] = "123"
dic["a", 0, "b", 1] = "123"
```

# Regras 

* Cada item de caminho pode possuir valores do tipo Int e String. Algumas regras existem para cada item desse: 
	* No caso do tipo String, os valores devem ser somente textos com caracteres numéricos e letras. 
	* Caso seja aplicado um texto que possua espaço, a atribuição não será realizado e a recuperação retornará nulo.

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




