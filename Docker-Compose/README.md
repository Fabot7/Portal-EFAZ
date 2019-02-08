# Portal da Escola Fazendária do Estado de Alagoas

&nbsp;
### Rancher-Catalog do Portal EFAZ

&nbsp;
#### Serão criados os seguintes serviços:
1. Aplicação WordPress (Container: *WordPressAplicacao*)

2. Banco de Dados (Container: *BancoMySQLWordPress*)

&nbsp;
#### Volumes Persistentes (Afinidade):
##### Chave = Valor
1. Aplicação: wordpressapp = wordpressapp

2. Banco de Dados: wordpressdb = wordpressdb

&nbsp;
#### Portas Internas:
1. WordPressAplicacao  -  Porta: 80

2. BancoMySQLWordPress - Porta: 3306

#### Portas Externas:
1. WordPressAplicacao  -  Porta: 8088

2. BancoMySQLWordPress -  Porta: 3307

&nbsp;
#### Endereço FQDN:
- efaz.sefaz.al.gov.br

&nbsp;
#### Uso
- Selecione a *Versão do Template (Template Version)*;
- Altere os parâmetros, se necessário;
- Preencha as credenciais de acesso dos serviços; e
- No final, clique em *Iniciar*.

&nbsp;
#### Releases

##### 1.0.0-SNAPSHOT
- Versão para testes de construção de imagens do Portal EFAZ, em WordPress.

##### 1 (sfz-portal-efaz:1.0.0-201810101030)
- Primeira versão do Portal EFAZ, em WordPress, na arquitetura de micro-serviços. Assim que estiver em Produção, o desenvolvedor realizará a instalação, configuração e população de conteúdo do portal.