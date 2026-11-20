# Meu primeiro projeto com Realidade Aumentada

Projeto feito com Vue 3 e Vite. A-Frame e AR.js são carregados por CDN no `index.html` (exige internet). As três imagens de referência enviadas foram incorporadas como fundos das seções para preservar a composição visual original. Os botões sobre os cartões são interativos.

## Executar
1. Instale Node.js .
2. Abra esta pasta no VS Code.
3. No terminal, execute `npm install`.
4. Execute `npm run dev`.
5. Abra o endereço local informado pelo Vite.
6. Aponte o marcador Hiro para a câmera | Você consegue o marcador nesse link https://raw.githubusercontent.com/AR-js-org/AR.js/master/data/images/hiro.png

## Experimentos
- EP. 001: abre a câmera e apresenta uma moldura de câmera virtual.
- EP. 002: abre a câmera, mas não apresenta objeto virtual.
- EP. 003: abre a câmera e apresenta olhos estilizados.

A câmera exige permissão do navegador e funciona em `localhost` ou em um endereço HTTPS. O rastreamento do marcador Hiro é feito pelo AR.js com A-Frame. O experimento 2 rastreia o marcador sem renderizar objeto virtual.
