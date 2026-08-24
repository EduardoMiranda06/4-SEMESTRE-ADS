# E1 — Backlog, Papéis, Cronograma, Riscos e Canvas Inicial
**Projeto:** Sistema de Gestão de Laboratórios e Ativos
**Demanda de referência:** SAGA SENAI de Inovação — Projeto 2026/01 6.02 19
**Empresa:** W K Soluções Industriais Ltda
**Unidade Curricular:** Projeto Integrador IV — 4º Semestre ADS
**Data de entrega:** até 13/08/2026

---

## 1. Backlog do Produto

Priorização usando MoSCoW (Must / Should / Could / Won't), com foco no fluxo mínimo ponta a ponta exigido no MVP.

| ID | User Story | Disciplina relacionada | Prioridade | Critério de aceite resumido |
|----|-------------|------------------------|------------|------------------------------|
| US01 | Como usuário, quero fazer login com senha protegida para acessar o sistema | Cibersegurança | Must | Login exige autenticação; bloqueia acesso sem credenciais válidas |
| US02 | Como administrador, quero ter permissões diferentes de um usuário comum | Cibersegurança | Must | Dois níveis de acesso (admin/usuário) com RBAC básico |
| US03 | Como gestor, quero cadastrar um novo ativo com patrimônio único | Aplicações Web | Must | Cadastro salvo no banco, patrimônio não duplicado |
| US04 | Como gestor, quero consultar, editar e inativar um ativo | Aplicações Web | Must | CRUD funcional com validação de campos |
| US05 | Como técnico, quero ler o QR Code do ativo pelo celular | Aplicações Mobile | Must | App reconhece o código e localiza o ativo correto |
| US06 | Como técnico, quero consultar dados do ativo (local, status, responsável) no app | Aplicações Mobile | Must | Tela exibe nome, patrimônio, local, responsável e situação |
| US07 | Como técnico, quero registrar uma movimentação ou abrir uma ordem de serviço pelo app | Aplicações Mobile / Web | Must | Ação gravada e refletida no histórico do sistema web |
| US08 | Como gestor, quero visualizar um painel com indicadores (ativos, OS abertas, manutenção) | Aplicações Web | Should | Painel exibe pelo menos 3 indicadores atualizados |
| US09 | Como usuário do app, quero apontar a câmera para o ativo e ver os dados em sobreposição (RA) | Realidade Aumentada | Should | Exibe ao menos 3 informações sobre a imagem da câmera |
| US10 | Como administrador, quero que ações críticas fiquem registradas em log | Cibersegurança | Must | Login, falhas, alterações de privilégio e movimentações são logados |
| US11 | Como responsável técnico, quero ter cópia de segurança do banco de dados | Cibersegurança | Must | Backup gerado e ao menos um teste de restauração evidenciado |
| US12 | Como usuário do app, quero uma alternativa de consulta caso a RA não funcione | Realidade Aumentada / Mobile | Should | Fallback para consulta convencional sem travar o fluxo |
| US13 | Como gestor, quero filtrar o histórico de movimentações e ordens de serviço | Aplicações Web | Could | Filtros por período, setor ou status |
| US14 | Como usuário, quero receber notificação de ordem de serviço atribuída | Aplicações Mobile | Could | Notificação local/push (se couber no MVP) |
| US15 | Como equipe, não vamos implementar autenticação por biometria neste MVP | Aplicações Mobile | Won't | Fora do escopo do semestre — registrado como possível evolução |

> **Observação:** o backlog deve ser migrado para o quadro Kanban do repositório (coluna *Backlog*) e atualizado a cada sprint, conforme exigido no item 3.8 (Ferramentas) da ementa de Gestão de Projetos.

---

## 2. Papéis do Grupo

| Integrante | Papel principal | Responsabilidade |
|------------|------------------|-------------------|
| [Nome 1] | Product Owner | Representa a necessidade da empresa W K Soluções Industriais, esclarece valor e prioriza o backlog |
| [Nome 2] | Facilitador / Scrum Master | Organiza reuniões semanais, mantém o quadro Kanban e remove impedimentos |
| [Nome 3] | Responsável técnico — Cibersegurança | Garante login, RBAC, validação, logs e backup |
| [Nome 4] | Responsável técnico — Web/API/Banco | Garante back-end, contrato REST e painel administrativo |
| [Nome 5] | Responsável técnico — Mobile/RA | Garante app, leitura de QR Code e módulo de realidade aumentada |

> Os papéis técnicos podem revezar entre sprints, mas cada disciplina deve ter um responsável claro em cada entrega (E1 a E5), conforme orientação do plano de ensino.

---

## 3. Cronograma (alinhado às 5 entregas cumulativas)

| Etapa | Prazo | Foco desta sprint | Marco |
|-------|-------|--------------------|-------|
| E1 — Descoberta | 13/08/2026 | Problema, usuários, requisitos, escopo, backlog, riscos e Canvas inicial | Problema validado |
| E2 — Projeto técnico | 10/09/2026 | Arquitetura, dados, contrato da API, UX, modelo de ameaças, PoC de leitura/RA | PoC executável |
| E3 — MVP alfa | 08/10/2026 | Web + API + banco + mobile integrados, login, leitura e primeira ação | Fluxo ponta a ponta |
| E4 — MVP beta | 05/11/2026 | Fluxo completo, segurança, logs, backup, testes e RA | Riscos tratados |
| E5 — Entrega final | 03/12/2026 | Versão final, documentação, pitch, defesa e submissão na SAGA | Produto validado |

### Cronograma detalhado da Sprint 1 (E1)

| Semana | Atividade | Responsável |
|--------|-----------|-------------|
| 1 | Leitura da demanda SAGA e levantamento do problema | Todo o grupo |
| 1 | Entrevista/pesquisa simulada com a "empresa" (baseada no cenário da proposta) | Product Owner |
| 2 | Definição de personas, jornada e benchmark | Product Owner + Empreendedorismo |
| 2 | Levantamento de requisitos funcionais, não funcionais e de segurança | Responsáveis técnicos |
| 3 | Criação do backlog e do quadro Kanban no repositório | Scrum Master |
| 3 | Elaboração do Canvas inicial | Product Owner |
| 4 | Registro de riscos e revisão geral do termo de abertura | Todo o grupo |
| 4 | Cadastro do grupo/projeto na plataforma SAGA | Product Owner |

---

## 4. Registro de Riscos

| ID | Risco | Categoria | Probabilidade | Impacto | Resposta | Responsável |
|----|-------|-----------|----------------|---------|----------|-------------|
| R01 | Integração entre app mobile e API atrasar por incompatibilidade de contrato | Técnico/Integração | Média | Alta | Definir contrato REST documentado já na E2, antes de codificar | Resp. Web/API |
| R02 | Dispositivo Android incompatível com ARCore para o módulo de RA | Dispositivo | Média | Média | Testar compatibilidade cedo (E2) e manter fallback de consulta convencional | Resp. Mobile/RA |
| R03 | Vazamento de credenciais ou dados sensíveis no repositório | Segurança/Dados | Baixa | Alta | Uso de `.env.example`, nunca commitar segredos, revisão de PR | Resp. Cibersegurança |
| R04 | Atraso na entrega por sobrecarga de uma única pessoa em tarefas críticas | Cronograma/Equipe | Média | Alta | Distribuir tarefas no Kanban com responsável e prazo visíveis | Scrum Master |
| R05 | Escopo crescer além do MVP (over-engineering) | Escopo | Média | Média | Reforçar definição de "o que não será desenvolvido" no termo de abertura | Product Owner |
| R06 | Dificuldade de acesso a licenças (Unity/Vuforia) para o módulo de RA | Licença/Ferramenta | Baixa | Média | Priorizar ferramentas gratuitas (ML Kit/ZXing) documentadas na ementa | Resp. Mobile/RA |
| R07 | Falha de comunicação entre integrantes sobre decisões tomadas | Comunicação | Média | Baixa | Atas curtas de reunião semanal registradas no repositório | Scrum Master |

---

## 5. Canvas Inicial (Modelo de Negócio Simplificado)

| Bloco | Conteúdo |
|-------|----------|
| **Problema** | Controle de ativos por anotações manuais gera atrasos, inconsistências, perda de informação e falta de rastreabilidade |
| **Segmento de clientes/usuários** | Gestores de laboratório, técnicos de manutenção e equipe operacional da W K Soluções Industriais |
| **Proposta de valor** | Sistema web + mobile que centraliza cadastro, consulta e movimentação de ativos, com identificação rápida via QR Code e visão contextual em RA |
| **Solução** | Aplicação web (gestão/painel), API central, banco de dados relacional, app mobile (leitura de código + RA) |
| **Canais** | Uso interno via navegador (web) e aplicativo instalado em dispositivos Android da equipe |
| **Recursos-chave** | Equipe de desenvolvimento, repositório Git, dispositivos Android para testes, ferramentas gratuitas/educacionais |
| **Custos principais** | Tempo de desenvolvimento (horas-aula), eventual licença de ferramentas de RA, hospedagem de teste (se necessário) |
| **Benefícios esperados** | Redução de inconsistências, maior agilidade na localização de ativos, centralização de dados, redução de retrabalho |
| **Diferencial frente ao processo manual** | Rastreabilidade automática, histórico de movimentações e consulta em tempo real via RA, eliminando o registro em papel |

---

## 6. Registro na Plataforma SAGA

- [ ] Projeto cadastrado na plataforma SAGA SENAI de Inovação sob o código **2026/01 6.02 19**
- [ ] Grupo e integrantes vinculados corretamente ao projeto
- [ ] Empresa parceira (W K Soluções Industriais Ltda) associada à demanda
- [ ] Print/evidência do cadastro salvo em `evidence/` no repositório

> Este cadastro é citado na trilha do Projeto Integrador IV como parte das atividades da E1 ("Cadastro na SAGA") e deve ser evidenciado junto com os demais artefatos desta entrega.

---

## Checklist de conformidade com o critério de aceite da E1
- [ ] Problema validado com clareza (quem sofre, por quê, impacto)
- [ ] Escopo viável e alinhado às restrições da proposta (baixo custo, tecnologias compatíveis com o nível da turma)
- [ ] Requisitos funcionais, não funcionais e de segurança listados e rastreáveis
- [ ] Backlog priorizado e vinculado ao quadro Kanban
- [ ] Papéis do grupo definidos e responsáveis por disciplina claros
- [ ] Riscos identificados com resposta e responsável
- [ ] Canvas inicial preenchido
- [ ] Cadastro na SAGA realizado e evidenciado
