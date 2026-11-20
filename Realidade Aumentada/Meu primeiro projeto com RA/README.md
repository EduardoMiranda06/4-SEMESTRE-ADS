# Meu primeiro projeto com Realidade Aumentada

**Três experimentos. Pouca utilidade. Muita tecnologia.**

## Sobre o projeto

Meu primeiro projeto com Realidade Aumentada é uma aplicação web interativa desenvolvida com o objetivo de explorar conceitos de Realidade Aumentada (RA) de maneira simples, experimental e descontraída.

A aplicação apresenta três experimentos que utilizam a câmera do dispositivo e o reconhecimento de marcadores para inserir elementos virtuais no ambiente real.

Além da parte tecnológica, o projeto possui uma identidade visual inspirada em colagens artesanais, recortes de revistas, papéis sobrepostos e elementos gráficos feitos à mão.

## Experimentos

### 01. Uma câmera com câmera

*Tecnologia olhando para tecnologia.*

Utiliza a câmera do dispositivo para apresentar uma câmera virtual sobre o marcador de Realidade Aumentada.

### 02. Objeto invisível

*Uma experiência que você não vê até se precisar. Talvez.*

Reconhece o marcador, mas não apresenta nenhum objeto virtual. A ausência de elementos faz parte da proposta do experimento.

### 03. Olhos em você

*Finalmente alguém prestando atenção.*

Apresenta dois olhos virtuais sobre o marcador, criando a impressão de que a própria realidade está observando o usuário.

## Tecnologias utilizadas

| Tecnologia | Aplicação |
|---|---|
| Vue 3 | Construção da interface e gerenciamento dos componentes |
| JavaScript | Lógica e interatividade da aplicação |
| JSON | Armazenamento dos dados dos experimentos |
| A-Frame | Criação e renderização dos elementos virtuais |
| AR.js | Reconhecimento de marcadores e recursos de Realidade Aumentada |
| Vite | Ambiente de desenvolvimento e build |

## Estrutura do projeto

```text
meu-primeiro-projeto-ra/
│
├── public/
│
├── src/
│   ├── assets/
│   ├── components/
│   │   ├── ExperimentCard.vue
│   │   ├── ARExperience.vue
│   │   └── EndingSection.vue
│   │
│   ├── data/
│   │   └── experiments.json
│   │
│   ├── App.vue
│   ├── main.js
│   └── style.css
│
├── index.html
├── package.json
├── vite.config.js
└── README.md
```

## Como executar

### Pré-requisitos

- Node.js instalado.
- Acesso à câmera.


```bash
cd meu-primeiro-projeto-ra
```

Instale as dependências:

```bash
npm install
```

Inicie o ambiente de desenvolvimento:

```bash
npm run dev
```

Acesse o endereço local apresentado pelo Vite no terminal.

### Acesso à câmera

Para utilizar os experimentos, é necessário permitir o acesso à câmera pelo navegador.

O acesso normalmente funciona em ambiente local (`localhost`) ou por meio de uma conexão HTTPS.

## Marcador de Realidade Aumentada

Os experimentos utilizam o marcador **Hiro**, reconhecido pelo AR.js.

O marcador deve estar visível para a câmera durante a execução das experiências.

## Objetivo acadêmico

O projeto busca aplicar conceitos de desenvolvimento web e Realidade Aumentada por meio da integração entre Vue 3, JSON, A-Frame e AR.js, explorando a interação entre elementos virtuais e o ambiente físico.

---

**Projeto acadêmico | Análise e Desenvolvimento de Sistemas | 2026**
