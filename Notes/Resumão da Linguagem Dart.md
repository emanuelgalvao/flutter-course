# Resumão da Linguagem Dart

### Variaveis

- Dart é fortemente tipada
- Pode declarar o tipo ou pode colocar como var e o tipo vai ser inferido

- Tipos de váriaveis
    - int 
    - double
    - bool
    - String
    - List
    - Map
    - Set

### Funções

```dart
// Retorno e parâmetros serão dynamic
soma(a, b) {
    return a + b;
}

// Retorno e parâmetros declaradamente int
int soma(int a, int b) {
    return a + b;
}

// Não retorna nada
void soma(int a, int b) {
    print("A soma é: ${a + b}");
}

// Passando função como parâmetro
void exec(int a, int b, int Function(int, int) fn) {
    return fn(a, b);
}

final result = exec(2, 3, (a, b) {
    return a - b;
})

print(result);

// Passando função como parâmetro usando Arrow Functions
final result2 = exec(2, 3, (a, b) => a * b + 100);

print(result2);
```

### Classes

```dart
class Produto {
    String nome;
    double preco;

    // Construtor da forma padrão
    Produto(String nome, double preco) {
        this.nome = nome,
        this.preco = preco
    }

    // Construtor otimizado - posicional
    Produto(this.nome, this.preco)

    // Construtor otimizado - nomeado
    Produto({this.nome, this.preco})

    // Construtor otimizado - com valores padrão
    Produto({this.nome, this.preco = 9.99})
}

main() {
    var p1 = new Produto();
    p1.nome = "Lapis";
    p1.preco = 4.49;

    var p2 = Produto('Caneta', 5.99);

    var p3 = Produto(nome: 'Caneta', preco: 5.99);

    print('O produto ${p1.nome} tem preço ${p1.preco}');
    print('O produto ${p2.nome} tem preço ${p2.preco}');
    print('O produto ${p3.nome} tem preço ${p3.preco}');
}
```