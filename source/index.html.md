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
aberto_vencidos       | Em aberto e vencidos
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


# Associados

Os associados são pessoas associadas ao sindicato.

## Obter token de acesso do associado

> Exemplo de requisição:

```shell
curl -X POST "https://webapi.afsys.com.br/v2/autenticar/associado" \
     -d "conta_id=20" \
     -d "cpf=12345678910" \
     -d "senha=Ab123456"
```

> Exemplo de resposta:

```json
{
  "auth_token": "[JWT-TOKEN-ASSOCIADO]"
}
```

### Query Parameters

Parametro          | Tipo    | Exemplo
------------------ | ------- | ----------------------------------------
conta_id           | integer | 20
cpf                | string  | 12345678910
senha              | string  | Ab123456

### HTTP Request

`POST https://webapi.afsys.com.br/v2/autenticar/associado`


## Consultar associado por login

> Exemplo de requisição:

```shell
curl -X POST "https://webapi.afsys.com.br/v2/associado/login" \
     -d "conta_id=1" \
     -d "cpf=11111111111"
```

> Exemplo de resposta:

```json
{
  "status": true,
  "sindicalizado": true,
  "status_cadastro": "cadastrado",
  "status_sindical": "sindicalizado",
  "nome": "LUIZ GOMES FAVERO DANIEL",
  "cpf": "12345678901",
  "celular_area": "",
  "celular_numero": "",
  "data_nascimento": "1985-02-26",
  "empresas": [
    {
      "status": "admitido",
      "descricao": "EMPRESA CONHECIDA LTDA",
      "tipo_vinculo": "empregado",
      "data_admissao": "2022-04-11",
      "data_demissao": null
    }
  ]
}
```

### Query Parameters

Parametro          | Tipo    | Exemplo
------------------ | ------- | ----------------------------------------
conta_id           | integer | 20
cpf                | string  | 12345678910

### HTTP Request

`POST https://webapi.afsys.com.br/v2/autenticar/associado`


## Obter associado logado

> Exemplo de requisição:

```shell
curl -X POST "https://webapi.afsys.com.br/v2/associado" \
     -H "Authorization: Bearer SEU-TOKEN"
```

> Exemplo de resposta:

```json
{
  "id": 6,
  "conta_id": 15,
  "cliente_id": null,
  "grupo_id": null,
  "associado_funcao_id": 1,
  "sub_sede_id": null,
  "posto_trabalho_id": null,
  "ferias": false,
  "sindicalizado": true,
  "aposentado": false,
  "socio_remido": false,
  "cancelado": false,
  "oposicao_contribuicao": false,
  "status_cadastro": "cadastrado",
  "status": "A",
  "tipo_vinculo": "",
  "matricula": "0000000001",
  "matricula_trabalhador": "T000000003",
  "titulo_eleitor": "",
  "cpf": "11111111111",
  "rg": "",
  "nome": "ASSOCIADO AFSYS TESTE",
  "sexo": "masculino",
  "email": "email@dominio.com",
  "nome_pai": "PAI",
  "nome_mae": "MÃE",
  "naturalizacao": "",
  "estado_civil": "",
  "telefone_area": "",
  "telefone_numero": "",
  "celular_area": "",
  "celular_numero": "",
  "carteira_trabalho": "",
  "pis": "",
  "empresa": "",
  "funcao": "",
  "salario_base": "0.00",
  "cep": "14030-570",
  "endereco": "Rua Gonçalves de Magalhães",
  "numero": "0",
  "complemento": "",
  "bairro": "Jardim Piratininga",
  "cidade": "Ribeirão Preto",
  "uf": "SP",
  "data_nascimento": "1984-05-24",
  "data_expedicao": null,
  "data_admissao": null,
  "data_demissao": null,
  "data_homologacao": null,
  "data_sindicalizacao": "2016-06-29",
  "notas": "",
  "senha": null,
  "carta_oposicao": false,
  "carteirinha_entregue": false,
  "validade_carteirinha": null,
  "afastamento_medico": false,
  "desconto_folha": false,
  "participa_votacao": true,
  "data_debito": null,
  "demitido": true,
  "data_obito": null,
  "cartao_convenio": false,
  "utiliza_convenio": false,
  "limite_convenio": "",
  "revisao_cadastro": null,
  "local_votacao": "empresa",
  "codigo_convenio": null,
  "autorizado": false,
  "recuperar_senha_token": null,
  "foto_updated_at": null,
  "foto_file_size": null,
  "foto_content_type": null,
  "foto_file_name": null,
  "created_at": "2016-06-29T18:58:50.000-03:00",
  "updated_at": "2021-03-16T12:11:03.000-03:00"
}
```

### HTTP Request

`POST https://webapi.afsys.com.br/v2/associado`

# Parceiros

## Listar parceiros

> Exemplo de requisição:

```shell
curl -X GET "https://webapi.afsys.com.br/v2/parceiros" \
     -H "Authorization: Bearer SEU-TOKEN"
```

> Exemplo de resposta:

```json
[
  {
    "id": 123456,
    "conta_id": 8,
    "aitvo": true,
    "pessoa_juridica": true,
    "nome": null,
    "razao_social": "RAZAO SOCIAL",
    "nome_fantasia": "NOME FANTASIA",
    "created_at": "2018-07-30T14:34:22.000-03:00",
    "updated_at": "2018-07-30T14:34:22.000-03:00",
    "imagens" : [
      "https://webapi.afsys.com.br/imagem-1.png",
      "https://webapi.afsys.com.br/imagem-2.png"
    ]
  },
  ...
]
```

### HTTP Request

`GET https://webapi.afsys.com.br/v2/parceiros`

### Query Parameters

Você poderá filtrar os parceiros pelo parâmetro abaixo:

Parametro  | Tipo    | Exemplo
---------- | ------- | ----------------------------------------------
s          | string  | Pesquisa pelo CPF, CNPJ, Nome ou Razão Social

## Obter parceiro por ID

> Exemplo de requisição:

```shell
curl -X GET "https://webapi.afsys.com.br/v2/parceiros/:id" \
     -H "Authorization: Bearer SEU-TOKEN"
```

> Exemplo de resposta:

```json
{
  "id": 87,
  "conta_id": 8,
  "ativo": true,
  "pessoa_juridica": true,
  "nome": "",
  "cpf": "",
  "razao_social": "RAZAO SOCIAL DO PARCEIRO",
  "nome_fantasia": "NOME FANTASIA DO PARCEIRO",
  "cnae": "94.20-1-00",
  "cnae_descricao": "Atividades de organizações sindicais",
  "site": "",
  "cnpj": "02971036000148",
  "crc": "",
  "contato": "",
  "telefone_area": "16",
  "telefone_numero": "8261113",
  "celular_area": "",
  "celular_numero": "",
  "email": "",
  "email_secundario": "",
  "cep": "14620-000",
  "endereco": "AVENIDA NOVE",
  "numero": "507",
  "complemento": "",
  "bairro": "CENTRO",
  "cidade": "ORLANDIA",
  "uf": "SP",
  "notas": "",
  "aplicacao_desconto": "ate",
  "tipo_desconto": "porcentagem",
  "valor_desconto": "0.0",
  "descricao_produto": null,
  "created_at": "2019-05-14T15:11:08.000-03:00",
  "updated_at": "2022-09-07T22:05:39.000-03:00",
  "imagens": [
    "http://localhost:3005/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBdFFIIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--8cfbc52c2475fe722bf9a27c644826cbdae1bd17/Eduardo_Azevedo.jpg",
    "http://localhost:3005/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBdFVIIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--86a0b6259f6fe6c0ea47c29252c0151e1dba38b7/eduardo.jpeg"
  ]
}
```

### HTTP Request

`GET https://webapi.afsys.com.br/v2/parceiros/:id`

### Query Parameters

Parametro  | Tipo    | Exemplo
---------- | ------- | ----------------------------------------------
id         | integer | Identificador do parceiro, ex: 123

# Agendas

## Listar agendamentos

> Exemplo de requisição:

```shell
curl -X GET "https://webapi.afsys.com.br/v2/agendas" \
     -H "Authorization: Bearer SEU-TOKEN"
```

> Exemplo de resposta:

```json
[
  {
    "id": 41885,
    "conta_id": 63,
    "servico_id": 420,
    "associado_id": null,
    "associado_dependente_id": null,
    "cliente_id": null,
    "parceiro_id": null,
    "servico_atendente_id": 56,
    "tipo_servico": "servico",
    "tipo_vinculo": "sem_cadastro",
    "status": "falta",
    "protocolo": "JLRDUYEM",
    "associado_nome": "não ",
    "cliente_nome": "Nenhum registro encontrado",
    "dependente_nome": null,
    "solicitante": "Jardel Martins ",
    "data": "2023-07-17",
    "horario": "2000-01-01T15:00:00.000-02:00",
    "observacao": "Jardel Martins - MP",
    "motivo_cancelamento": null,
    "created_at": "2023-07-17T14:11:11.000-03:00",
    "updated_at": "2023-07-17T16:07:56.000-03:00"
  },
  ...
]
```

### HTTP Request

`GET https://webapi.afsys.com.br/v2/agendas`

### Query Parameters

Parametro          | Tipo    | Exemplo
------------------ | ------- | ----------------------------------------
status             | string  | agendado, concluido, cancelado, falta
servico_id         | integer | 123
parceiro_id        | integer | 123
associado_id       | integer | 123
cliente_id         | integer | 123
data               | date    | 2025-01-30

## Obter agendamento por ID

### HTTP Request

`GET https://webapi.afsys.com.br/v2/agendas/123`

> Exemplo de requisição:

```shell
curl -X GET "https://webapi.afsys.com.br/v2/agendas/123" \
     -H "Authorization: Bearer SEU-TOKEN"
```

> Exemplo de resposta:

```json
{
  "id": 41885,
  "conta_id": 63,
  "servico_id": 420,
  "associado_id": null,
  "associado_dependente_id": null,
  "cliente_id": null,
  "parceiro_id": null,
  "servico_atendente_id": 56,
  "tipo_servico": "servico",
  "tipo_vinculo": "sem_cadastro",
  "status": "falta",
  "protocolo": "JLRDUYEM",
  "associado_nome": "não ",
  "cliente_nome": "Nenhum registro encontrado",
  "dependente_nome": null,
  "solicitante": "Jardel Martins ",
  "data": "2023-07-17",
  "horario": "2000-01-01T15:00:00.000-02:00",
  "observacao": "Jardel Martins - MP",
  "motivo_cancelamento": null,
  "created_at": "2023-07-17T14:11:11.000-03:00",
  "updated_at": "2023-07-17T16:07:56.000-03:00"
}
```

## Criar agendamento

> Exemplo de requisição:

```shell
curl -X POST "https://webapi.afsys.com.br/v2/agendas" \
     -H "Authorization: Bearer SEU-TOKEN" \
     -d "agenda[servico_id]=123" \
     -d "agenda[associado_id]=123" \
     -d "agenda[associado_dependente_id]=123" \
     -d "agenda[cliente_id]=123" \
     -d "agenda[parceiro_id]=123" \
     -d "agenda[servico_atendente_id]=123" \
     -d "agenda[tipo_servico]=servico" \
     -d "agenda[tipo_vinculo]=empregado" \
     -d "agenda[status]=agendado" \
     -d "agenda[associado_nome]=José da Silva" \
     -d "agenda[cliente_nome]=José da Silva" \
     -d "agenda[solicitante]=Luiz Felipe" \
     -d "agenda[data]=2025-01-30" \
     -d "agenda[horario]=10:30" \
     -d "agenda[observacao]=Nada consta" \
     -d "agenda[motivo_cancelamento]=Test"
```

### HTTP Request

`POST https://webapi.afsys.com.br/v2/agendas`

### Parâmetros e tipagem

Parametro               | Tipo    | Exemplo
----------------------- | ------- | ----------------------------------------
status                  | string  | agendado, concluido, cancelado, falta
tipo_servico            | string  | servico, convenio
tipo_vinculo            | string  | sem_cadastro, empregado, sem_vinculo, aposentado, autonomo, cliente
servico_id              | integer | 123
parceiro_id             | integer | 123
associado_id            | integer | 123
cliente_id              | integer | 123
associado_dependente_id | integer | 123
servico_atendente_id    | integer | 123
data                    | date    | 2025-01-30
horario                 | time    | 10:30
associado_nome          | string  | José da Silva
cliente_nome            | string  | José da Silva
observacao              | text    | Texto descritivo
motivo_cancelamento     | text    | Texto descritivo

> Exemplo de resposta:

```json
{
  "id": 41885,
  "conta_id": 63,
  "servico_id": 420,
  "associado_id": null,
  "associado_dependente_id": null,
  "cliente_id": null,
  "parceiro_id": null,
  "servico_atendente_id": 56,
  "tipo_servico": "servico",
  "tipo_vinculo": "sem_cadastro",
  "status": "falta",
  "protocolo": "JLRDUYEM",
  "associado_nome": "não ",
  "cliente_nome": "Nenhum registro encontrado",
  "dependente_nome": null,
  "solicitante": "Jardel Martins ",
  "data": "2023-07-17",
  "horario": "2000-01-01T15:00:00.000-02:00",
  "observacao": "Jardel Martins - MP",
  "motivo_cancelamento": null,
  "created_at": "2023-07-17T14:11:11.000-03:00",
  "updated_at": "2023-07-17T16:07:56.000-03:00"
}
```
