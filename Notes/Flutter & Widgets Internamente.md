# Flutter e Widgets Internamente

## Árvore de Widgets & Árvore de Elementos

**Widget Tree (Imutável) - Widgets ficam aqui**
- Configuração - Reconstruido frequentemente

**Element Tree (Estrutura lógica) - States ficam aqui**
- Liga Widget com o objeto rendenizado - Raramente reconstruido

**Reender Tree (O que vê na tela)**
- Objeto rendenizado na tela - Raramente reconstruido

### Quando o método build é chamado?

- Quando a tela é criada
- Quando é atualizado um estado que o componente utiliza
- Quando mudam as informações do MediaQuery.of - Ex: Quando rotaciona o device, abre o teclado, muda o tamanho da interface

### Construtores e Widgets Constantes

- Podemos ter construtores constantes em widgets, é só colocar o `const`na frente do construtor
- Só funciona se as váriaveis que são passadas para o widget forem definidas em tempo de compilação
- Com o `const` o widget nunca será reconstruido, o que melhora a performance

### Ciclo de Vida dos Widgets

##### Stateless Widgets

-> Construtor -> build()

##### Statefull Widgets

-> Construtor -> initState() -> build()
-> setState() -> didUpdateWidget() -> build()
-> dispose() - Chamado quando o componente sai da tela

### Ciclo de Vida da Aplicação

- inativo
- paused - App não visivel, executando em background
- resumed - App novamente visivel e respondendo ao usuário
- suspending - App será suspensa (sair)

### Context

- Cada Widget tem seu context e é único
- Context é uma META Informação sobre o Widget e sua localização na árvore de componentes
