<script setup>
import { ref, nextTick } from 'vue'
import { experiments } from './data'
import ARExperience from './components/ARExperience.vue'
import cover from './assets/capa.png'
import experimentsImage from './assets/experimentos.png'
import ending from './assets/fim-da-realidade.png'

const active = ref(null)
const panel = ref(null)

async function choose(item) {
  active.value = item
  await nextTick()
  panel.value?.scrollIntoView({ behavior: 'smooth', block: 'center' })
}
function closeExperiment() {
  active.value = null
}
function goToExperiments() {
  document.getElementById('experimentos')?.scrollIntoView({ behavior: 'smooth' })
}
function goToStart() {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}
</script>

<template>
  <main>
    <section class="art-section cover" :style="{ backgroundImage: `url(${cover})` }" aria-label="Meu primeiro projeto com Realidade Aumentada">
      <button class="cover-hit" @click="goToExperiments" aria-label="Ir para os experimentos"></button>
      <div class="scroll-hint" @click="goToExperiments">ROLE PARA COMEÇAR <span>↓</span></div>
    </section>

    <section id="experimentos" class="art-section experiments" :class="{ 'is-active': active }" :style="{ backgroundImage: `url(${experimentsImage})` }">
      <!-- Desktop: áreas clicáveis invisíveis exatamente sobre os botões desenhados na imagem -->
      <button
        v-for="item in experiments"
        :key="item.id"
        class="hotspot"
        :class="`hotspot-${item.id}`"
        @click="choose(item)"
        :aria-label="`${item.action} — ${item.title}`"
      ></button>

      <!-- Celular: a imagem de fundo é cortada, então os cartões são desenhados em HTML -->
      <div class="mobile-ui">
        <h2>O que vamos testar hoje?</h2>
        <button v-for="item in experiments" :key="item.id" class="m-card" :class="`m-card-${item.id}`" @click="choose(item)">
          <small>EP. 00{{ item.id }}</small>
          <strong>{{ item.title }}</strong>
          <span>{{ item.description }}</span>
          <em>{{ item.action }} ↗</em>
        </button>
        <h2>Área de experimentação</h2>
      </div>

      <div ref="panel" class="ar-panel" :class="{ open: active }">
        <!-- Estado de espera: no desktop quem mostra é a imagem; no celular, esta caixa -->
        <div v-if="!active" class="waiting" aria-live="polite">
          <span class="plus">＋</span>
          <strong>Aguardando um experimento...</strong>
        </div>
        <div v-else class="active-experiment">
          <div class="active-heading">
            <span>EP. 00{{ active.id }}</span>
            <strong>{{ active.title }}</strong>
            <button @click="closeExperiment" class="close">FECHAR ×</button>
          </div>
          <ARExperience :key="active.id" :experiment="active" />
        </div>
      </div>
    </section>

    <section class="art-section ending" :style="{ backgroundImage: `url(${ending})` }" aria-label="Fim da realidade">
      <!-- Área clicável invisível sobre o botão "Voltar ao início" desenhado na imagem -->
      <button class="back-home" @click="goToStart" aria-label="Voltar ao início"></button>
    </section>
  </main>
</template>
