# Como o Provider funciona?

- É um provedor de dados
- Possui um estado
- Vai ser um container dos componentes que precisam desse estado
- Todos os componentes filhos vão ter acesso a esse provider
- Acesso atraves do `.of(context)`

- Não precisa estar na raiz da aplicação
- Pode estar em um ramo especifico da arvore de componentes