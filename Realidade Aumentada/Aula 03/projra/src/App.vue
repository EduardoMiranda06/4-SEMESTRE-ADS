<script setup>
import { ref, computed } from 'vue'
import produtos from './data/produtos.json'
import ProdutoCard from './components/ProdutoCard.vue'
import CenaRA from './components/CenaRA.vue'

const busca = ref('')
const produtoSelecionado = ref(null)

const produtosFiltrados = computed(() => {
  const termo = busca.value.toLowerCase().trim()
  if (!termo) return produtos

  return produtos.filter((produto) =>
    `${produto.nome} ${produto.categoria}`.toLowerCase().includes(termo)
  )
})

function abrirRA(produto) {
  produtoSelecionado.value = produto
}

function fecharRA() {
  produtoSelecionado.value = null
}
</script>

<template>
  <main>
    <header class="topo">
      <div>
        <span class="tag">AULA PRÁTICA • VUE 3 + RA</span>
        <h1>Ferramentas <span>3D</span></h1>
        <p>Catálogo de ferramentas com ficha técnica e Realidade Aumentada.</p>
      </div>

      <input
        v-model="busca"
        type="search"
        placeholder="Buscar produto..."
        aria-label="Buscar produto"
      />
    </header>

    <section class="hero">
      <div>
        <h2>Veja o produto no mundo real.</h2>
        <p>
          Escolha uma ferramenta, clique em <b>VER EM RA</b> e aponte a câmera
          para o marcador HIRO.
        </p>
      </div>
      <div class="hero-icon">📱</div>
    </section>

    <section class="catalogo">
      <div class="section-title">
        <h2>Produtos</h2>
        <span>{{ produtosFiltrados.length }} item(ns)</span>
      </div>

      <div v-if="produtosFiltrados.length" class="grid">
        <ProdutoCard
          v-for="produto in produtosFiltrados"
          :key="produto.id"
          :produto="produto"
          @ver-ra="abrirRA"
        />
      </div>

      <p v-else class="vazio">Nenhum produto encontrado.</p>
    </section>

    <CenaRA
      v-if="produtoSelecionado"
      :produto="produtoSelecionado"
      @fechar="fecharRA"
    />
  </main>
</template>