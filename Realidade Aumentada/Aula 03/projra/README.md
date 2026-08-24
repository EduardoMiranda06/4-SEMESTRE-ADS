# Projeto RA — Vue 3 + Vite + A-Frame + AR.js

Projeto didático de catálogo de ferramentas com Realidade Aumentada usando Vue 3, Vite, A-Frame 1.6.0 e AR.js 3.4.7.

## 1. Requisitos

- Node.js 18 ou superior
- Navegador atualizado com acesso à câmera
- Para usar a câmera no celular, o endereço deve estar em HTTPS. `localhost` é permitido pelo navegador como contexto seguro.

## 2. Instalação

Abra o terminal dentro desta pasta e execute:

```bash
npm install
npm run dev
```

Abra o endereço informado pelo Vite.

## 3. Realidade Aumentada

O projeto utiliza o marcador HIRO:

`public/assets/hiro.png`

Clique em **VER EM RA**, permita o uso da câmera e aponte a câmera para o marcador HIRO.

A integração de AR.js para A-Frame é carregada no `index.html` com a versão 3.4.7, compatível com o A-Frame 1.6.0 usado no projeto.

## 4. Teste no celular

Não use somente um endereço HTTP de rede local, como:

`http://192.168.x.x:5173`

Em muitos navegadores a câmera será bloqueada nesse caso. Para testar no celular, use HTTPS.

## 5. Build

Para testar a compilação de produção:

```bash
npm run build
```

## Estrutura

- `src/App.vue` — página principal e seleção do produto
- `src/components/ProdutoCard.vue` — card de produto
- `src/components/CenaRA.vue` — tela de Realidade Aumentada
- `src/data/produtos.json` — dados dos produtos
- `public/assets/hiro.png` — marcador HIRO
- `public/assets/*.png` — imagens dos produtos
- `index.html` — carregamento do A-Frame e AR.js
