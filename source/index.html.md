---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell: cURL

toc_footers:
  - <a href="https://afsys.com.br" target="_blank">Afsys - Gestão Sindical</a>

includes:
  - errors

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
500    | *Internal Server Error*  | Quando ocorrer um erro interno no recurso da API

# Controle de retornos

Cada linguagem de programação adota um tipo de composição diferente para classes, métodos, funções e variáveis. Normalmente, nos deparamos com os tipos *CamelCase*, *snake_case* e *dash-case*, sendo assim, disponibilizamos o atributo **X-Key-Inflection** que poderá ser enviado no HEADER da requisição.

Os valores válidos para esse atributo são: **camel**, **dash**, ou **snake**.

Por padrão, **X-Key-Inflection = snake**

**Nota**:

*CamelCase* é a prática de escrever palavras compostas ou frases, onde cada palavra é iniciada com maiúsculas e unidas sem espaços.

*SnakeCase* é a prática de escrever palavras compostas ou frases, onde as palavras são separadas por um caractere de sublinhado (_) e sem espaços.

*DashCase* é a prática de escrever palavras compostas ou frases, onde as palavras são separadas por um caractere de traço (-) e sem espaços.

# Autenticação

O processo de autenticação do AFSYS-API é realizado através da requisição ``POST /auth/login``, que deve retornar um token de identificação válido por 24 horas. Esse token tem como objetivo identificar quem é o usuário que está requisitando o recurso do AFSYS-API.

Essa identificação é importante para registrar o requerente e, ao mesmo tempo, verificar se o mesmo tem permissão para acessar o recurso solicitado.

Para obter um token de identificação válido, é necessário passar um usuário e senha ativo no sistema.

# Obtendo Token

> Para autenticar utilize o trecho a seguir:


```shell
# With shell, you can just pass the correct header with each request
curl -X POST "https://painel.afsys.com.br/api/v1/autenticar" \
  -d email=EMAIL \
  -d senha=SENHA \
```

> Substitua EMAIL e SENHA pelos dados que lhes forem passados.

<aside class="notice">
  Substitua <code>EMAIL</code> e <code>SENHA</code> pelos dados que lhes forem passados.
</aside>

> Tendo como retorno o json abaixo:

```json
  {"auth_token":"TOKEN"}
```

O token possui 24 horas para expiração.

### HTTP Request

`POST https://painel.afsys.com.br/api/v1/autenticar`

### Query Parameters

Parametro    | Tipo |
------------ | ------- |
email | string   |
senha    | string    |

<aside class="success">
  Remember — a happy kitten is an authenticated kitten!
</aside>

## Get a Specific Kitten

```shell
curl "http://example.com/api/kittens/2"
  -H "Authorization: meowmeowmeow"
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "name": "Max",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

This endpoint retrieves a specific kitten.

<aside class="warning">Inside HTML code blocks like this one, you can't use Markdown, so use <code>&lt;code&gt;</code> blocks to denote code.</aside>

### HTTP Request

`GET http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID        | The ID of the kitten to retrieve

## Delete a Specific Kitten

```shell
curl "http://example.com/api/kittens/2"
  -X DELETE
  -H "Authorization: meowmeowmeow"
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "deleted" : ":("
}
```

This endpoint deletes a specific kitten.

### HTTP Request

`DELETE http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID        | The ID of the kitten to delete
