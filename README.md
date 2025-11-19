Prezados Avaliadores,

Durante a análise e implementação da integração com a API da CoinMarketCap, identifiquei um **desafio na obtenção de dados** que exigiu uma solução proativa:

### 1. Desafio da Obtenção de Metadados

O *endpoint* de metadados (`/v1/exchange/info`) exige que os identificadores (`id` ou `slug`) sejam enviados **obrigatoriamente** na requisição. Como esses dados não estavam disponíveis ou listados previamente na atividade, não foi possível utilizá-lo diretamente.

### 2. Solução Encontrada (Descoberta do `Map`)

Para obter a lista de identificadores, recorri ao *endpoint* de listagem (`/v1/exchange/map`), que fornece todos os `id`s e `slugs` disponíveis.

### 3. Problema na Implementação e Justificativa do *Hard-Code*

Ao tentar usar os *slugs* retornados pelo `/map` e passá-los ao `/info` de forma dinâmica, o *endpoint* de metadados retornou **erros de forma inconsistente** para a maioria dos *slugs*, dificultando a identificação de um padrão de validação ou de um filtro seguro.

**Para garantir a entrega da feature e demonstrar o mapeamento de dados:** Optei por contornar o problema, utilizando *hard-code* em alguns parâmetros (`slugs`) válidos, que foram testados manualmente, no *endpoint* `/v1/exchange/info`.

Gostaria de pontuar que a solução final não é a ideal para um ambiente de produção (que exigiria um *cache* dos dados do `/map` e uma lógica de *fallback* robusta), mas foi essencial para **validar a camada de serviço e a decodificação da API**.

Agradeço a oportunidade e fico à disposição para detalhar qualquer aspecto técnico da solução.
