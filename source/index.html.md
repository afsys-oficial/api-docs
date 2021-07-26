---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell: cURL

toc_footers:
  - <a href="https://afsys.com.br" target="_blank">Afsys - Gestão Sindical</a>

search: true
---

# Introdução

Disponibilizamos essa API com o intuito de fornecer acesso aos recursos do Afsys - Gestão Sindical por meio da arquitetura RESTful, dessa forma, você poderá fazer uso dos recursos do nosso sistema fora do nosso ambiente UI, e com isso, contextualizar melhor as funcionalidades dentro da sua necessidade.

# Visão geral

O objetivo desta documentação é orientar o desenvolvedor sobre como integrar com o AFSYS-API, descrevendo as funcionalidades, os métodos a serem utilizados, listando informações a serem enviadas e recebidas, e provendo exemplos.

O mecanismo de integração com o AFSYS-API é simples, de modo que apenas conhecimentos intermediários em linguagem de programação para Web, requisições HTTP/HTTPS e manipulação de arquivos JSON são necessários para integrar com o AFSYS-API.

Nesse manual você encontrará a referência sobre todas as operações disponíveis na API REST do AFSYS-API. As operações devem ser executadas utilizando um token de acesso obtido através do recurso de autenticação. Esse token é gerado com base em um usuário e senha ativo no Afsys.

Disponibilizamos abaixo as urls de acesso aos nossos ambientes:

**Ambiente Produção:** https://webapi.afsys.com.br

**Ambiente Homologação:** https://apphml.afsys.com.br/api

# Códigos de status

No AFSYS-API, os status de retorno das requisições devem ser esperados conforme especificado nas situações abaixo:

CÓDIGO | DESCRIÇÃO                | SITUAÇÃO
-------|--------------------------|-----------------------------------------------
200    | *OK*                     | Requisição atendida com sucesso
201    | *Created*                | Registro criado (geralmente em método POST /recurso)
204    | *No Content*             | Registro alterado ou excluído (geralmente em método PATCH ou DELETE /recurso)
401    | *Unauthorized*           | Token ausente, expirado ou não autorizado
403    | *Forbidden*              | Acesso proibido ao recurso requisitado (usuário sem permissão)
404    | *Resource Not Found*     | Registro ou recurso não encontrado
422    | *Unprocessable Entity*   | Quando ocorrer erros de validação, como, um campo obrigatório não informado
429    | *Too Many Requests*      | Excedeu o seu limite de requisições por minuto
500    | *Internal Server Error*  | Quando ocorrer um erro interno no recurso da API
502    | *Bad Gateway*            | Sistema em atualização, voltaremos em poucos segundos
503    | *Service Unavailable*    | No momento estamos offline para manutenção no sistema, tente mais tarde

# Controle de retornos

Cada linguagem de programação adota um tipo de composição diferente para classes, métodos, funções e variáveis. Normalmente, nos deparamos com os tipos *CamelCase*, *snake_case* e *dash-case*, sendo assim, disponibilizamos o atributo **X-Key-Inflection** que poderá ser enviado no HEADER da requisição.

Os valores válidos para esse atributo são: **camel**, **dash**, ou **snake**.

Por padrão, **X-Key-Inflection = snake**

**Nota**:

*CamelCase* é a prática de escrever palavras compostas ou frases, onde cada palavra é iniciada com maiúsculas e unidas sem espaços.

*SnakeCase* é a prática de escrever palavras compostas ou frases, onde as palavras são separadas por um caractere de sublinhado (\_) e sem espaços.

*DashCase* é a prática de escrever palavras compostas ou frases, onde as palavras são separadas por um caractere de traço (-) e sem espaços.

# Autenticação

O processo de autenticação do AFSYS-API é realizado através da requisição ``POST /auth/login``, que deve retornar um token de identificação válido por 24 horas. Esse token tem como objetivo identificar quem é o usuário que está requisitando o recurso do AFSYS-API.

Essa identificação é importante para registrar o requerente e, ao mesmo tempo, verificar se o mesmo tem permissão para acessar o recurso solicitado.

Para obter um token de identificação válido, é necessário passar um usuário e senha ativo no sistema.

## Obtendo o Token

> Exemplo de requisição:

```shell
# With shell, you can just pass the correct header with each request
curl -X POST "https://webapi.afsys.com.br/v2/autenticar" \
  -d email=EMAIL \
  -d senha=SENHA \
```
<aside class="notice">
  Substitua os atributos <code>EMAIL</code> e <code>SENHA</code> pelos dados fornecidos pelo administrador do sistema.
</aside>

> Exemplo de resposta:

```json
{
  "auth_token": "TOKEN"
}
```

O token de identificação é válido por 24 horas.

### HTTP Request

`POST https://webapi.afsys.com.br/v2/autenticar`

### Query Parameters

Parametro    | Tipo    |
------------ | ------- |
email        | string  |
senha        | string  |


# Contas

No Afsys os sindicatos possuem uma conta no sistema onde todos os contribuintes, associados, boletos e etc pertecem a essa conta. Para cada conta são criados vários usuários e perfis de acesso, e assim, cada um terá o acesso de acordo com suas responsabilidades no sistema.

## Previsão orçamentaria

> Exemplo de requisição:

```shell
curl -H "Authorization: SEU-TOKEN" -X GET https://webapi.afsys.com.br/v2/contas/previsao_orcamentaria
```

> Exemplo de resposta:

```json
{
  "ano": 2010,
  "valor": 10,
  "valor_baixado": 10
}
```

### Query Parameters

Parametro             | Tipo    | Exemplo
--------------------- | ------- | ----------------------------------------
motivo_cancelamento   | text    | Boleto com problema

### HTTP Request

`https://webapi.afsys.com.br/v2/contas/previsao_orcamentaria`

### HTTP Request

`GET https://webapi.afsys.com.br/v2/contas/previsao_orcamentaria`


## Mensalidades

Esse recurso retornará as mensalidades dos clientes Afsys.

> Exemplo de requisição:

```shell
curl -H "Authorization: SEU-TOKEN" -X GET https://webapi.afsys.com.br/v2/contas/mensalidades
```

> Exemplo de resposta:

```json
{
  "id": 2257282,
  "conta_id": 115,
  "cliente_id": 196825,
  "associado_id": null,
  "convenio_id": 516,
  "remessa_id": null,
  "registrado": true,
  "remessa_local": false,
  "data_emissao": "2020-01-31",
  "data_remessa": null,
  "data_pagamento": null,
  "data_credito": null,
  "status": "C",
  "layout": "santander",
  "competencia": "04/2018",
  "numero_documento": "20039757",
  "nosso_numero": "200000039757",
  "data_vencimento": "2018-05-10",
  "pagador_nome": "NOME DO PAGADOR",
  "pagador_documento": "12345678901234",
  "juros": null,
  "multa": null,
  "desconto": null,
  "valor": "163.92",
  "valor_pago": null,
  "visualizacao": 0,
  "ultima_visualizacao": null,
  "data_cancelamento": null,
  "link_boleto": "https://app.afsys.com.br/boletos/impresso/M95581049374544003",
  "cliente": {
    "id": 196825,
    "conta_id": 115,
    "pessoa_juridica": true,
    "cpf": null,
    "nome": "",
    "cnpj": "12345678901234",
    "razao_social": "NOME DO PAGADOR",
    "nome_fantasia": "NOME DO PAGADOR"
  },
  "associado": null
}
```

### HTTP Request

`https://webapi.afsys.com.br/v2/contas/mensalidades`

## Visualizar conta

Esse recurso retornará os dados da conta no AFSYS.

> Exemplo de requisição:

```shell
curl -H "Authorization: SEU-TOKEN" -X GET https://webapi.afsys.com.br/v2/conta
```

> Exemplo de resposta:

```json
{
  "id": 1,
  "status": "A",
  "permalink": "nw956klr",
  "email": "comercial@afsys.com.br",
  "pessoa_juridica": true,
  "nome": "",
  "cpf": "",
  "cnpj": "81574631000116",
  "razao_social": "Afsys Apresentação Sindicato",
  "nome_fantasia": "Sinthoresca",
  "cnae": "",
  "cnae_descricao": "",
  "rateio_federacao": "0.00",
  "site": "",
  "telefone_area": "16",
  "telefone_numero": "33333333",
  "celular_area": "",
  "celular_numero": "",
  "cep": "14000-000",
  "endereco": "Rua Vicente golfeto",
  "numero": "2",
  "complemento": "",
  "bairro": "CAMPOS",
  "cidade": "RIBEIRAO PRETO",
  "uf": "SP",
  "logo_url": "https://app.afsys.com.br/uploads/contas/1/original/logo.jpg?1520854626"
}
```

### HTTP Request

`https://webapi.afsys.com.br/v2/conta`


# Clientes

Com esse recurso você poderá filtrar pelos contribuintes cadastrados no Afsys.

## Listar clientes

> Exemplo de requisição:

```shell
curl -X GET "https://webapi.afsys.com.br/v2/clientes" \
     -H "Authorization: Bearer SEU-TOKEN"
```

> Exemplo de resposta:

```json
[
  {
    "id": 320660,
    "conta_id": 8,
    "status": "A",
    "pessoa_juridica": true,
    "cpf": null,
    "nome": null,
    "cnpj": "12345678901234",
    "razao_social": "RAZAO SOCIAL DO CLIENTE",
    "nome_fantasia": "NOME FANTASIA DO CLIENTE"
  },
  ...
]
```

### HTTP Request

`GET https://webapi.afsys.com.br/v2/clientes`

### Campo Status

Logo abaixo você pode conferir os possíveis valores para o campo `status` do cliente

Status | Descrição
-------|---------------------------------------------------
A      | Ativado
D      | Desativado

### Query Parameters

Você poderá filtrar os clientes pelo parâmetro abaixo:

Parametro  | Tipo    | Exemplo
---------- | ------- | ----------------------------------------------
s          | string  | Pesquisa pelo CPF, CNPJ, Nome ou Razão Social


# Convênios

Os convênios são utilizados para definir a carteira de cobrança adquirida com banco e as regras de multas, juros e descontos.

## Listar convênios

> Exemplo de requisição:

```shell
curl -X GET "https://webapi.afsys.com.br/v2/convenios" \
     -H "Authorization: Bearer SEU-TOKEN"
```

> Exemplo de resposta:

```json
[
  {
    "id": 568,
    "ativo": true,
    "visualiza": true,
    "padrao": false,
    "competencia": false,
    "mensagem_competencia": true,
    "acordo": false,
    "link_boleto_email": false,
    "imprime_boleto": false,
    "created_at": "2018-07-30T14:34:22.000-03:00",
    "updated_at": "2019-03-07T11:07:41.000-03:00",
    "tipo_convenio": {
      "id": 11,
      "descricao": "CONTRIBUICAO ASSISTENCIAL",
      "created_at": "2016-06-30T15:33:38.000-03:00",
      "updated_at": "2016-06-30T15:33:38.000-03:00"
    }
  },
  ...
]
```

### HTTP Request

`GET https://webapi.afsys.com.br/v2/convenios`


# Boletos

Esse recurso fornece os recursos necessários para LISTAR, VISUALIZAR, CRIAR e CANCELAR boletos no sistema

## Listar boletos

> Exemplo de requisição:

```shell
curl -X GET "https://webapi.afsys.com.br/v2/boletos" \
     -H "Authorization: Bearer SEU-TOKEN"
```

> Exemplo de resposta:

```json
[
  {
    "id": 2257282,
    "conta_id": 115,
    "cliente_id": 196825,
    "associado_id": null,
    "convenio_id": 516,
    "remessa_id": null,
    "registrado": true,
    "remessa_local": false,
    "data_emissao": "2020-01-31",
    "data_remessa": null,
    "data_pagamento": null,
    "data_credito": null,
    "status": "O",
    "layout": "santander",
    "competencia": "04/2018",
    "numero_documento": "20039757",
    "nosso_numero": "200000039757",
    "data_vencimento": "2018-05-10",
    "pagador_nome": "NOME DO PAGADOR",
    "pagador_documento": "12345678901234",
    "juros": null,
    "multa": null,
    "desconto": null,
    "valor": "163.92",
    "valor_pago": null,
    "visualizacao": 0,
    "ultima_visualizacao": null,
    "data_cancelamento": null,
    "link_boleto": "https://app.afsys.com.br/boletos/impresso/M15804934474595003",
    "cliente": {
      "id": 196825,
      "conta_id": 115,
      "pessoa_juridica": true,
      "cpf": null,
      "nome": "",
      "cnpj": "12345678901234",
      "razao_social": "NOME DO PAGADOR",
      "nome_fantasia": "Tantô Temakeria"
    },
    "associado": null
  },
  ...
]
```

### HTTP Request

`GET https://webapi.afsys.com.br/v2/boletos`

### Query Parameters

Você poderá filtrar os boletos pelos parâmetros abaixo:

Parametro           | Tipo    | Exemplo
------------------- | ------- | ----------------------------------------
convenio_id         | integer | 123
cliente_id          | integer | 123
associado_id        | integer | 123
tipo_pagador        | string  | "cliente" ou "associado"
status              | string  | Veja o item "Status dos boletos"
emissao_inicial     | string  | 01/01/2020 ou 2020-01-01
emissao_final       | string  | 01/01/2020 ou 2020-01-01
vencimento_inicial  | string  | 01/01/2020 ou 2020-01-01
vencimento_final    | string  | 01/01/2020 ou 2020-01-01
nosso_numero        | string  | AB0000123456
seu_numero          | string  | AB0000123456
\_page              | string  | 1
\_limit             | string  | 30

### Status dos boletos

O itens abaixo podem ser utilizados no filtro de boletos por status.

Status                | Descrição
----------------------|---------------------------------------------------
emitido               | Emitido
pendente              | Remessa pendente
pendente_vencido      | Remessa pendente (boleto vencido)
pendente_nao_vencido  | Remessa pendente (boleto não vencido)
remetido              | Remetido
remetido_nao_vencido  | Remetido (boleto não vencido)
rejeitado             | Rejeitado
baixados              | Baixado
pagos                 | Pagos
aberto                | Em aberto
aberto_remessa        | Em aberto (boletos registrados e não registrados)
vencidos              | Vencido
vencidos_remessa      | Vencido (boletos registrados e não registrados)
cancelados            | Cancelado
negociados            | Negociado
juridico              | Jurídico

### Sigla de status dos boletos

No sistema, os status dos boletos são compostos por uma letra. Logo abaixo você pode conferir o significado de cada letra de status:

Status | Descrição
-------|--------------------------
E      | Emitido
O      | Remessa pendente
R      | Remetido
A      | Em aberto
I      | Rejeitado
B      | Baixado
D      | Baixado por não pagamento
P      | Pago
C      | Cancelado
N      | Negociado
J      | Jurídico


## Totalizador de boletos

> Exemplo de requisição:

```shell
curl -X GET "https://webapi.afsys.com.br/v2/boletos/totalizador" \
     -H "Authorization: Bearer SEU-TOKEN"
```

> Exemplo de resposta:

```json
{
  "quantidade": 50,
  "valor_total": "10000.10",
  "total_pago": 1300.00,
  "total_tarifas": 27.00
}
```

### HTTP Request

`GET https://webapi.afsys.com.br/v2/boletos/totalizador`


### Query Parameters

Você poderá filtrar os boletos pelos parâmetros abaixo:

Parametro           | Tipo    | Exemplo
------------------- | ------- | ----------------------------------------
convenio_id         | integer | 123
cliente_id          | integer | 123
associado_id        | integer | 123
tipo_pagador        | string  | "cliente" ou "associado"
status              | string  | Veja o item "Status dos boletos"
emissao_inicial     | string  | 01/01/2020 ou 2020-01-01
emissao_final       | string  | 01/01/2020 ou 2020-01-01
vencimento_inicial  | string  | 01/01/2020 ou 2020-01-01
vencimento_final    | string  | 01/01/2020 ou 2020-01-01

## Visualizar boleto

> Exemplo de requisição:

```shell
curl -X GET "https://webapi.afsys.com.br/v2/boletos/123" \
     -H "Authorization: Bearer SEU-TOKEN"
```

> Exemplo de resposta:

```json
{
  "id": 2257282,
  "conta_id": 115,
  "cliente_id": 196825,
  "associado_id": null,
  "convenio_id": 516,
  "remessa_id": null,
  "registrado": true,
  "remessa_local": false,
  "data_emissao": "2020-01-31",
  "data_remessa": null,
  "data_pagamento": null,
  "data_credito": null,
  "status": "O",
  "layout": "santander",
  "competencia": "04/2018",
  "numero_documento": "20039757",
  "nosso_numero": "200000039757",
  "data_vencimento": "2018-05-10",
  "pagador_nome": "NOME DO PAGADOR",
  "pagador_documento": "12345678901234",
  "juros": null,
  "multa": null,
  "desconto": null,
  "valor": "163.92",
  "valor_pago": null,
  "visualizacao": 0,
  "ultima_visualizacao": null,
  "data_cancelamento": null,
  "link_boleto": "https://app.afsys.com.br/boletos/impresso/M95581049374544003",
  "cliente": {
    "id": 196825,
    "conta_id": 115,
    "pessoa_juridica": true,
    "cpf": null,
    "nome": "",
    "cnpj": "12345678901234",
    "razao_social": "NOME DO PAGADOR",
    "nome_fantasia": "Tantô Temakeria"
  },
  "associado": null
}
```

### HTTP Request

`GET https://webapi.afsys.com.br/v2/boletos`

## Criar boleto

> Exemplo de requisição:

```shell
curl -X POST "https://webapi.afsys.com.br/v2/boletos/123" \
     -H "Authorization: Bearer SEU-TOKEN" \
     -d "boleto[associado_id]=79616" \
     -d "boleto[convenio_id]=80" \
     -d "boleto[data_vencimento]=2020-02-20" \
     -d "boleto[valor]=127.32" \
     -d "boleto[competencia_mes]=2" \
     -d "boleto[competencia_ano]=2020" \
     -d "boleto[enviar_email]=false"
```

### Query Parameters

Parametro          | Tipo    | Exemplo
------------------ | ------- | ----------------------------------------
convenio_id        | integer | 123
cliente_id         | integer | 123
associado_id       | integer | 123
data_vencimento    | date    | 01/01/2020 ou 2020-01-01
valor              | integer | 123.12
competencia_mes    | integer | 01
competencia_ano    | integer | 2020
enviar_email       | boolean | TRUE ou FALSE

> Exemplo de resposta:

```json
{
  "id": 2257282,
  "conta_id": 115,
  "cliente_id": 196825,
  "associado_id": null,
  "convenio_id": 516,
  "remessa_id": null,
  "registrado": true,
  "remessa_local": false,
  "data_emissao": "2020-01-31",
  "data_remessa": null,
  "data_pagamento": null,
  "data_credito": null,
  "status": "O",
  "layout": "santander",
  "competencia": "04/2018",
  "numero_documento": "20039757",
  "nosso_numero": "200000039757",
  "data_vencimento": "2018-05-10",
  "pagador_nome": "NOME DO PAGADOR",
  "pagador_documento": "12345678901234",
  "juros": null,
  "multa": null,
  "desconto": null,
  "valor": "163.92",
  "valor_pago": null,
  "visualizacao": 0,
  "ultima_visualizacao": null,
  "data_cancelamento": null,
  "link_boleto": "https://app.afsys.com.br/boletos/impresso/M95581049374544003",
  "cliente": {
    "id": 196825,
    "conta_id": 115,
    "pessoa_juridica": true,
    "cpf": null,
    "nome": "",
    "cnpj": "12345678901234",
    "razao_social": "NOME DO PAGADOR",
    "nome_fantasia": "Tantô Temakeria"
  },
  "associado": null
}
```

### HTTP Request

`POST https://webapi.afsys.com.br/v2/boletos`

## Cancelar boleto

> Exemplo de requisição:

```shell
curl -X PATCH "https://webapi.afsys.com.br/v2/boletos/123/cancelar" \
     -H "Authorization: Bearer SEU-TOKEN" \
     -d "boleto[motivo_cancelamento]=Mensagem de cancelamento" \
```

> Exemplo de resposta:

```json
{
  "id": 2257282,
  "conta_id": 115,
  "cliente_id": 196825,
  "associado_id": null,
  "convenio_id": 516,
  "remessa_id": null,
  "registrado": true,
  "remessa_local": false,
  "data_emissao": "2020-01-31",
  "data_remessa": null,
  "data_pagamento": null,
  "data_credito": null,
  "status": "C",
  "layout": "santander",
  "competencia": "04/2018",
  "numero_documento": "20039757",
  "nosso_numero": "200000039757",
  "data_vencimento": "2018-05-10",
  "pagador_nome": "NOME DO PAGADOR",
  "pagador_documento": "12345678901234",
  "juros": null,
  "multa": null,
  "desconto": null,
  "valor": "163.92",
  "valor_pago": null,
  "visualizacao": 0,
  "ultima_visualizacao": null,
  "data_cancelamento": null,
  "link_boleto": "https://app.afsys.com.br/boletos/impresso/M95581049374544003",
  "cliente": {
    "id": 196825,
    "conta_id": 115,
    "pessoa_juridica": true,
    "cpf": null,
    "nome": "",
    "cnpj": "12345678901234",
    "razao_social": "NOME DO PAGADOR",
    "nome_fantasia": "NOME DO PAGADOR"
  },
  "associado": null
}
```

### Query Parameters

Parametro             | Tipo    | Exemplo
--------------------- | ------- | ----------------------------------------
motivo_cancelamento   | text    | Boleto com problema

### HTTP Request

`PATCH https://webapi.afsys.com.br/v2/boletos/:id/cancelar`

### HTTP Request

`GET https://webapi.afsys.com.br/v2/contas/previsao_orcamentaria`


# Associados Interessados

Os associados interessados são pessoas que desejam se associar ao sindicato. Esses recurso gerará um pré-cadastro de associados que poderá aprovado ou reprovado dentro do sistema.

## Criar associado interessado

> Exemplo de requisição:

```shell
curl -X POST "https://webapi.afsys.com.br/v2/associado_interessado" \
     -H "Authorization: Bearer SEU-TOKEN" \
     -d "associado_interessado[status]=A" \
     -d "associado_interessado[funcao]=Atendente" \
     -d "associado_interessado[cpf]=11111111111" \
     -d "associado_interessado[rg]=11.111.11-X" \
     -d "associado_interessado[data_expedicao]=2021-01-01" \
     -d "associado_interessado[nome]=Jose da Silva" \
     -d "associado_interessado[data_nascimento]=1990-01-01" \
     -d "associado_interessado[sexo]=masculino" \
     -d "associado_interessado[email]=email@dominio.com.br" \
     -d "associado_interessado[nome_pai]=" \
     -d "associado_interessado[nome_mae]=" \
     -d "associado_interessado[naturalizacao]=São Paulo" \
     -d "associado_interessado[estado_civil]=Casado(a)" \
     -d "associado_interessado[telefone_area]=11" \
     -d "associado_interessado[telefone_numero]=999999999" \
     -d "associado_interessado[celular_area]=11" \
     -d "associado_interessado[celular_numero]=999999999" \
     -d "associado_interessado[cep]=04843425" \
     -d "associado_interessado[endereco]=Viela 16" \
     -d "associado_interessado[numero]=123" \
     -d "associado_interessado[complemento]=Casa" \
     -d "associado_interessado[bairro]=Parque São José" \
     -d "associado_interessado[cidade]=São Paulo" \
     -d "associado_interessado[uf]=SP" \
     -d "associado_interessado[tipo_vinculo]=empregado" \
     -d "associado_interessado[cnpj]=12345678901234" \
     -d "associado_interessado[carteira_trabalho]=" \
     -d "associado_interessado[salario_base]=1200"
```

### Query Parameters

Parametro          | Tipo    | Exemplo
------------------ | ------- | ----------------------------------------
status             | string  | A ou D
funcao             | string  | até 255 caracteres
cpf                | string  | 12345678911
rg                 | string  | 12.222.333-X
data_expedicao     | date    | 2021-01-01
nome               | string  | até 60 caracteres
data_nascimento    | date    | 2021-01-01
sexo               | string  | masculino ou feminino
email              | string  | até 160 caracteres
nome_pai           | string  | até 60 caracteres
nome_mae           | string  | até 60 caracteres
naturalizacao      | string  | até 160 caracteres
estado_civil       | string  | Casado(a), Solteiro(a), Divorciado(a), Viúvo(a), Separado(a), Companheiro(a)
telefone_area      | string  | 11
telefone_numero    | string  | 999999999
celular_area       | string  | 11
celular_numero     | string  | 999999999
cep                | string  | 11111-000
endereco           | string  | até 255 caracteres
numero             | string  | até 15 caracteres
complemento        | string  | até 255 caracteres
bairro             | string  | até 255 caracteres
cidade             | string  | até 60 caracteres
uf                 | string  | até 2 caracteres
tipo_vinculo       | string  | empregado, aposentado, sem_vinculo, autonomo
cnpj               | string  | 11111111111111
carteira_trabalho  | string  | até 40 caracteres
salario_base       | float   | 111111.11

### HTTP Request

`POST https://webapi.afsys.com.br/v2/associado_interessado`
