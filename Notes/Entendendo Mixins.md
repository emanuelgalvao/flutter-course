# Entendendo Mixins

- É um trecho de código que você pode "copiar" para dentro da sua classe, de forma a ela ter acesso a esse código

```dart
class Carro {
    int _velocidade = 0;

    int acelerar() {
        _velocidade += 5;
        return _velocidade;
    }

    int freiar() {
        _velocidade -= 5;
        return _velocidade;
    }
}

mixin Turbo {
    bool _turboLigado = false;

    ligarTurbo() {
        _turboLigado = true;
    }

    desligarTurbo() {
        _turboLigado = false;
    }
}

class Ferrari extends Carro  with Turbo {
    @override
    int acelerar() {
        if (_turboLigado) {
            super.acelerar();
        }
        super.acelerar();
    }
}

void main() {
    var carro = Carro();
    carro.acelerar();   // Velocidade = 5
    carro.ligarTurbo(); // Velocidade = 5
    carro.acelerar();   // Velocidade = 15
    carro.acelerar();   // Velocidade = 25
    carro.freiar();     // Velocidade = 20
}
```