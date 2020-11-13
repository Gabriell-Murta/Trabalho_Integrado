# Tarefaê

3º aplicativo desenvolvido para as aulas de LDDM do curso de Engenharia de Computação

## Documentação

O aplicativo consiste de uma única tela, na qual é possível adicionar itens de texto na lista através de um FloatingActionButton, e removê-los através de botões à direita de cada item da lista. Idealmente, é uma ferramenta para gerenciar listas de tarefas, com controle de datas.

## Estrutura
1. main.dart (Inicializa o app);
2. app.dart (Define e configura o MaterialApp, chama a Home Page);
3. controllers (Item do MVC, declara as funções do model);
4. views (Item do MVC, armazena as páginas do app);
5. repositories (Item do MVC, lida com as operações de escrita e leitura em arquivo);
6. models (Item do MVC, declara a estrutura dos dados);
