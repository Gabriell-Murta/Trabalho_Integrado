# Dispositivo

Aplicativo desenvolvido em grupo para o Trabalho Integrado. Esther e Flávia : View e model | Gabriell e José : repository | Hugo e João : controllers
link do swagger:
https://tapegandofogobicho.azurewebsites.net/swagger/index.html

## Contexto

Desenvolver um dispositivo IoT conectado à nuvem através de MQTT, que pode ser posicionado em locais estratégicos para detecção e previsão de queimadas, com acesso a um aplicativo mobile de monitoramento de todos os dispositivos, suas localizações e possíveis queimadas. Os dados serão armazenados em um banco MySQL, e acessáveis através de um backend baseado em C#, e hospedado em nuvem.

## Documentação

O aplicativo consiste de uma única tela, na qual é possível visualizar os nomes, ID e localização dos dispositivos. Idealmente, é uma ferramenta para visualizar os dispositivos de monitoramento dos clientes.

## Estrutura
1. main.dart (Inicializa o app);
2. app.dart (Define e configura o MaterialApp, chama a Home Page);
3. controllers (Declara as funções do model);
4. views (Armazena a página do app);
5. repositories (Llida com as operações de escrita e leitura em arquivo);
6. models (Declara a estrutura dos dados);
