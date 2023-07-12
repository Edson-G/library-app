### Padrões de projeto

O projeto utiliza algumas _design patterns_ comuns em orientações objetos, como por exemplo:

- Singleton
  - As classes CommandInterpreter e LibrarySystem não possuem construtores públicos, e seus único construtores privados são usados como valor inicial para um atributo `instance` declarado como `static final`. Desta forma, a referência à instância nunca muda durante todo o runtime da aplicação.
- Command
  - A interface (definida no dart como `abstract class`) `LibraryCommand` possui um método `execute` que é sobreescrito com os métodos dos comandos da aplicação (tais como "emp" e "liv").
- Strategy
  - As regras de negócio específicas a tipos diferentes de usuário estão parametrizadas e isoladas em classes que são intercambiáveis.

Além disso, alguns pontos importantes sobre a arquitetura devem ser destacados:

- Considerando a boa prática da única fonte de verdade e os cuidados que devem ser tomados ao trabalhar com listas, o usuário, representado pela classe `User`, não tem internamente os dados sobre seus empréstimos e reservas.
  - O maior ganho observado é que isso evita ter que constantemente atualizar listas diferentes, em classes diferentes, mantendo ainda a integridade dos dados.
  - O custo é que a classe `LibrarySystem` tem mais dificuldade em realizar a inferface entre usuários e livros. Além disso, apesar de os métodos de LibrarySystem variarem com parâmetros dinâmicos dependentes de uma Strategy, o método em si não pode ser extraído e substituido facilmente, portanto, algumas alterações na regra de negócio podem exigir uma violação do princípio do aberto/fechado.
    - Na estrutura atual, não tem solução fácil para esse problema.
    - A solução ideal iria exigir repensar a forma de armazenar os dados. Por exemplo, se todos os dados fossem salvos em um banco de dados relacional, poderíamos ter, em runtime um `User` que tranquilamente conteria os dados do seu empréstimo e reservas.desde que o mesmo atuasse apenas como model ou dto. Desse modo, o seu estado seria apenas uma representação efêmera do estado do banco, o qual seria a fonte real dos dados da aplicação.
  - Alguns comportamentos são delegados para o próprio livro na classe `Book`, desde que sejam comportamentos específicos a um livro ou a seus exemplares. Dessa forma, o Book atua como expert sempre que possível.

Por fim, o projeto segue as convenções do linter padrão do Dart. Foi considerada a possibilidade de usar um conjunto mais amplo de regras de linter ou até mesmo outras ferramentas de análise estática de código, porém algumas regras mais modernas poderiam criar conflitos com a proposta do projeto. Para mais detalhes, veja a última seção deste README

### Diagrama UML

Considerando os requisitos do projeto, optamos por utilizar uma ferramenta que gera o diagrama UML do projeto de acordo com as classes presentes. Isso permitiu um workflow mais dinâmico onde é possível ver, em tempo real, o diagrama de classes atualmente implementado.

Para detalhes de como utilizar a mesma ferramenta, confira a página do [Dart Class Diagram Generator](https://pub.dev/packages/dcdg)

### Considerações finais

O projeto serviu como uma experiência incrível de aprendizado, pois exigiu um estudo mais aprofundado dos princípios e padrões vistos durante o semestre. Apesar de conter requisitos de negócio simples, o foco em implementar os padrões de projeto fez com que o projeto não fosse trivial de implementar.

Dito isso, algumas melhorias podem ser feitas. Devem existir alguns pontos de melhoria que não foram observados pela equipe, porém, algumas melhorias foram deliberadamente evitadas por motivos específicos, por exemplo:

#### Modernização do padrão Command.

O padrão Command, conceitualmente, traz um grande ganho de robustez à aplicação seguindo fielmente os princípios da responsabilidade única e aberto/fechado. Entretanto, em termos de implementação, algumas features modernas ajudariam bastante no processo.

O maior problema é que a interface `LibraryCommand` não precisa existir no projeto. No Dart, bem como em diversas linguagens de programação modernas, funções são [objetos de primeira classe](https://dart.dev/language/functions#functions-as-first-class-objects). Isso permite, por exemplo, que métodos sejam declarados fora de uma classe e, posteriormente, passados como valores em um `Map`.

```dart
  // Exemplo com padrão command. Corpo dos métodos execute oculto para fins de simplificar o exemplo
  abstract class Command {
    void execute(){}
  }

  class FirstCommand extends Command {
    @override
    void execute(){}
  }

  class SecondCommand extends Command {
    @override
    void execute(){}
  }

  class CommandInterpreter {
    void interpretCommand() {
      Map<String, Command> commandByName = {
        'one': FirstCommand(),
        'two': SecondCommand(),
      };
    }
  }

  // Alternativa com funções sendo objetos de primeira classe
  void firstCommand(){}

  void secondCommand(){}

  class CommandInterpreter {
    void interpretCommand() {
      Map<String, void Function()> commandByName = {
        'one': firstCommand,
        'two': secondCommand,
      };
    }
  }
```

É importante destacar que essa abordagem moderna é fortemente recomendada na documentação oficial do Dart, no artigo [Effective Dart:design](https://dart.dev/effective-dart/design#avoid-defining-a-one-member-abstract-class-when-a-simple-function-will-do). Existe, inclusive, uma regra opcional do linter padrão do Dart para detectar casos de interfaces com apenas um método declarado: [one_member_abstracts](https://dart.dev/tools/linter-rules/one_member_abstracts).

Considerando que um dos propósitos do trabalho é de praticar o uso dos padrões de projetos, optamos por manter o uso do padrão Command conforme visto em linguagens sem funções como objetos de primeira classe. Por outro lado, a reflexão sobre os padrões de projeto usados é igualmente importante, portanto, decidimos reservar este espaço para relatar estas considerações.
