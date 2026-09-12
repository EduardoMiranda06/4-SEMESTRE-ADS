# Roteiro de Apresentação
## Reconhecimento em Segurança Ofensiva — Recon-ng, EyeWitness e theHarvester

*Tempo estimado total: 8-10 minutos (ajuste conforme o tempo disponível)*

---

### Slide 1 — Capa
**Tempo: ~20s**

> "Boa tarde/bom dia a todos. Hoje eu vou falar sobre a fase de reconhecimento em segurança ofensiva, usando três ferramentas como estudo de caso: Recon-ng, EyeWitness e theHarvester. A ideia é entender como um profissional de segurança — ou um atacante — coleta informação sobre um alvo antes de qualquer tentativa de ataque."

*Dica: fale devagar aqui, é o momento de captar atenção. Não leia o slide, apresente-se.*

---

### Slide 2 — Agenda
**Tempo: ~20s**

> "Vou seguir essa ordem: primeiro explico o que é a fase de reconhecimento e por que ela existe. Depois apresento cada ferramenta separadamente — o que faz e como funciona. No final, mostro como elas se complementam na prática e fecho falando sobre os limites éticos e legais desse tipo de trabalho."

*Dica: não leia os 6 itens em voz alta um por um — resuma em blocos, como acima.*

---

### Slide 3 — O que é a fase de Reconhecimento
**Tempo: ~50s**

> "Antes de atacar qualquer sistema, um profissional precisa entender o alvo. Essa etapa se chama Reconhecimento, e é sempre a primeira do ciclo de um pentest — antes de varredura, exploração e relatório, como vocês veem no diagrama à direita.
>
> Existem dois tipos: o reconhecimento **passivo**, onde você não interage diretamente com o alvo — só consulta fontes públicas, como buscadores e registros de DNS — e o **ativo**, onde já existe interação direta, como um escaneamento de portas.
>
> As três ferramentas que vou apresentar hoje atuam principalmente no reconhecimento passivo. Isso é importante porque significa que, na maior parte do tempo, o alvo nem percebe que está sendo investigado."

*Dica: aponte para o diagrama do ciclo do pentest ao falar "primeira etapa".*

---

### Slide 4 — Recon-ng (visão geral)
**Tempo: ~35s**

> "A primeira ferramenta é o Recon-ng. É um framework de reconhecimento escrito em Python, com uma interface de linha de comando muito parecida com a do Metasploit — quem já viu Metasploit vai reconhecer a lógica na hora.
>
> Ele foi criado por Tim Tomes e o grande diferencial dele é que não faz só uma coisa: ele organiza, automatiza e centraliza dezenas de técnicas diferentes de coleta de informação em um só lugar."

---

### Slide 5 — Recon-ng (funcionalidades)
**Tempo: ~50s**

> "Pra entender como ele funciona na prática, tem alguns conceitos-chave. Primeiro, os **workspaces** — cada investigação fica isolada em um espaço próprio, com seu próprio banco de dados de resultados, então você não mistura informação de alvos diferentes.
>
> Segundo, os **módulos** — são scripts pequenos e especializados, organizados por categoria: reconhecimento, descoberta, geração de relatório. Você não carrega tudo de uma vez, instala só o que precisa através do que eles chamam de marketplace.
>
> Ele também se integra com **APIs externas**, como Shodan e Hunter.io, pra enriquecer os dados. E tudo isso fica estruturado num banco interno, que pode ser exportado depois em HTML, CSV ou JSON."

*Dica: se a banca perguntar um comando, cite: `workspaces create`, `marketplace install`, `modules load`, `run`.*

---

### Slide 6 — EyeWitness (visão geral)
**Tempo: ~30s**

> "A segunda ferramenta é o EyeWitness, criada pela equipe da FortyNorth Security. Diferente do Recon-ng, ela resolve um problema bem específico: triagem visual. Ela recebe uma lista de URLs ou hosts e gera capturas de tela automáticas de cada um, organizando tudo num relatório."

---

### Slide 7 — EyeWitness (funcionalidades)
**Tempo: ~45s**

> "O funcionamento dela segue quatro passos. Primeiro, ela recebe a lista de alvos — pode ser um arquivo de texto com URLs, ou hosts com serviços de RDP e VNC expostos. Segundo, ela abre cada um num navegador headless, ou seja, sem interface gráfica, e tira a captura automaticamente. Terceiro, ela categoriza os resultados — separa páginas de login, páginas de erro, alvos de alta confiança. E por fim, gera um relatório HTML único, com miniaturas clicáveis.
>
> O valor disso na prática é enorme: imagina ter que abrir manualmente 300 URLs no navegador pra ver o que tem em cada uma. O EyeWitness transforma isso em uma revisão visual de poucos minutos."

---

### Slide 8 — theHarvester (visão geral)
**Tempo: ~30s**

> "A terceira ferramenta é o theHarvester, criada por Christian Martorella. O foco dela é bem diferente das outras duas: coleta passiva de e-mails, subdomínios, hosts e nomes de funcionários ligados a um domínio, consultando várias fontes públicas ao mesmo tempo."

---

### Slide 9 — theHarvester (fontes de dados)
**Tempo: ~40s**

> "Ela cruza informação de múltiplas fontes numa única execução. Motores de busca como Google e Bing indexam páginas e e-mails públicos. Redes profissionais, como o LinkedIn, revelam nomes de funcionários e cargos. Servidores de chave PGP guardam e-mails associados a chaves públicas. E serviços como crt.sh, que analisa certificados digitais, revelam subdomínios que às vezes nem aparecem em uma busca comum — como ambientes de desenvolvimento esquecidos."

*Dica: se perguntarem "por que isso é perigoso", responda: um subdomínio tipo dev.empresa.com costuma estar menos protegido que o site principal — é um alvo clássico.*

---

### Slide 10 — Comparativo
**Tempo: ~35s**

> "Resumindo as diferenças: o Recon-ng é uma ferramenta de orquestração — ele organiza e cruza dados. O EyeWitness é focado em triagem visual — ele transforma listas em imagens. E o theHarvester é uma ferramenta de coleta bruta — ele gera a matéria-prima de e-mails e hosts. Cada uma tem uma entrada e uma saída diferente, como está na tabela."

*Dica: não leia a tabela linha por linha — só destaque a lógica geral acima.*

---

### Slide 11 — Fluxo de uso integrado
**Tempo: ~35s**

> "Na prática, essas ferramentas não são usadas isoladamente, elas se complementam. Um fluxo comum seria: primeiro o theHarvester mapeia e-mails e subdomínios do alvo. Depois o Recon-ng organiza, cruza e enriquece esses dados com módulos e APIs adicionais. E por fim, o EyeWitness pega a lista final de hosts e URLs e gera a triagem visual, pra o analista decidir onde focar o esforço manual.
>
> Vale dizer que essa ordem não é uma regra fixa — na prática, o analista alterna entre as ferramentas conforme novas informações vão surgindo."

---

### Slide 12 — Ética e considerações legais
**Tempo: ~45s**

> "É importante deixar claro: essas ferramentas só devem ser usadas em ambientes com autorização formal — um contrato de pentest, um laboratório próprio, ou uma plataforma de CTF.
>
> Um ponto que costuma gerar dúvida: o fato de o dado ser público não significa que reunir e correlacionar essas informações seja automaticamente permitido. Dependendo do contexto, isso pode até esbarrar em legislações como a LGPD, especialmente quando envolve dados de pessoas.
>
> O objetivo desse estudo é acadêmico: entender como um atacante pensa, justamente para conseguir construir defesas melhores — não para uso indevido."

*Dica: esse é o slide mais provável de gerar perguntas da banca — se preparem para justificar o "por quê" de estudar essas ferramentas.*

---

### Slide 13 — Conclusão
**Tempo: ~30s**

> "Para concluir: Recon-ng, EyeWitness e theHarvester cobrem, juntas, o essencial da fase de reconhecimento — organização de dados, coleta de informação pública e triagem visual de alvos. Entender como elas funcionam ajuda tanto quem trabalha atacando sistemas de forma autorizada, quanto quem trabalha defendendo — porque mostra exatamente que tipo de informação uma organização está expondo sem perceber.
>
> Fico à disposição para perguntas."

---

## Perguntas frequentes (prepare respostas curtas)

| Pergunta provável | Resposta-base |
|---|---|
| Isso é hacking? | Não no sentido de invasão — é coleta de informação pública (OSINT). Nenhuma das três explora vulnerabilidades. |
| Por que 3 ferramentas e não 1? | Cada uma resolve um problema diferente: coleta bruta, organização/correlação e visualização. Nenhuma substitui as outras. |
| É legal usar isso? | Só com autorização explícita — contrato de pentest, laboratório próprio ou CTF. Sem isso, mesmo dado público pode gerar problema legal (LGPD, ToS dos serviços consultados). |
| Qual a diferença entre Recon-ng e uma busca manual no Google? | O Recon-ng automatiza, estrutura em banco de dados e cruza múltiplas fontes de forma repetível — uma busca manual não escala e não se integra a outras fontes. |
| Vocês testaram alguma dessas ferramentas? | Responda com sinceridade. Se testou em ambiente próprio/laboratório, mencione isso — reforça a credibilidade e mostra que entendeu a parte ética. |

---

## Dicas gerais de apresentação

- **Não leia os slides** — use-os como apoio visual, fale com suas palavras usando este roteiro como guia mental.
- **Aponte para os elementos visuais** (ícones, tabela, diagrama de fluxo) enquanto fala — isso guia o olhar da plateia.
- **Pratique a transição entre slides** — frases como "agora que vimos X, vamos entender Y" deixam a apresentação mais fluida.
- **Guarde o slide 12 (ética) para responder bem** — é o que mais gera perguntas em contextos acadêmicos de segurança.
