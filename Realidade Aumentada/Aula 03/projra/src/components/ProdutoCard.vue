<script setup> 

// Recebe os dados do produto enviados pelo componente pai
defineProps({ 

  // Cria uma propriedade chamada "produto"
  produto: { 

    // O produto deve ser um objeto
    type: Object, 

    // O componente precisa obrigatoriamente receber um produto
    required: true 
  } 
}) 


// Cria o evento "ver-ra"
// Esse evento será utilizado para avisar o componente pai
// que o usuário deseja visualizar o produto em Realidade Aumentada
const emit = defineEmits(['ver-ra']) 
</script> 


<template> 

  <!--
    CARD DO PRODUTO

    <article> representa o conteúdo de um produto.
    class="card" aplica o estilo visual do cartão.
  -->
  <article class="card"> 


    <!--
      IMAGEM DO PRODUTO

      :src="produto.imagem"
      → busca no objeto produto o endereço da imagem.

      :alt="produto.nome"
      → utiliza o nome do produto como texto alternativo.

      class="produto-img"
      → aplica o estilo definido para a imagem.
    -->
    <img :src="produto.imagem" :alt="produto.nome" class="produto-img" /> 


    <!--
      ÁREA DE INFORMAÇÕES DO PRODUTO

      Contém categoria, nome, descrição,
      especificações, preço e botão de RA.
    -->
    <div class="card-body"> 


      <!--
        CATEGORIA DO PRODUTO

        {{ produto.categoria }}
        → mostra a categoria armazenada no objeto produto.
      -->
      <span class="categoria">{{ produto.categoria }}</span> 


      <!--
        NOME DO PRODUTO

        {{ produto.nome }}
        → mostra o nome do produto.
      -->
      <h2>{{ produto.nome }}</h2> 


      <!--
        DESCRIÇÃO DO PRODUTO

        {{ produto.descricao }}
        → mostra a descrição armazenada no objeto produto.
      -->
      <p>{{ produto.descricao }}</p> 


      <!--
        ESPECIFICAÇÕES DO PRODUTO

        A div agrupa as informações técnicas
        apresentadas no card.
      -->
      <div class="specs"> 


        <!-- Potência do produto -->
        <span>{{ produto.potencia }}</span> 


        <!-- Voltagem do produto -->
        <span>{{ produto.voltagem }}</span> 


        <!-- Peso do produto -->
        <span>{{ produto.peso }}</span> 


      </div> 


      <!--
        PREÇO DO PRODUTO

        produto.preco
        → acessa o preço no objeto produto.

        toFixed(2)
        → mantém duas casas decimais.

        replace('.', ',')
        → troca o ponto decimal por vírgula.

        Exemplo:

        1500.5
          ↓
        1500.50
          ↓
        1500,50

        Resultado apresentado:

        R$ 1500,50
      -->
      <strong class="preco"> 
        R$ {{ produto.preco.toFixed(2).replace('.', ',') }} 
      </strong> 


      <!--
        BOTÃO DE REALIDADE AUMENTADA

        @click
        → executa uma ação quando o usuário clicar.

        emit('ver-ra', produto)
        → envia o evento "ver-ra" para o componente pai.

        produto
        → envia junto todos os dados do produto.

        Dessa forma, o componente pai sabe
        qual produto deve ser exibido na RA.
      -->
      <button class="btn-ra" @click="emit('ver-ra', produto)"> 
        📱 VER EM RA 
      </button> 


    </div> 

  </article> 

</template>