<script setup>

import { onMounted, ref } from 'vue'
// onMounted → executa uma função quando o componente é carregado
// ref → cria variáveis reativas no Vue

defineProps({
  produto: {
    type: Object,
    required: true
  }
})
// defineProps → recebe dados enviados pelo componente pai
// produto → objeto que contém os dados do produto
// type: Object → informa que produto é um objeto
// required: true → informa que o produto é obrigatório

const emit = defineEmits(['fechar'])
// defineEmits → permite enviar um evento para o componente pai
// 'fechar' → nome do evento que será enviado quando o usuário fechar a RA

const status = ref('abrindo')
// status controla o estado da câmera
// 'abrindo' → câmera está sendo inicializada
// 'ok' → câmera foi aberta com sucesso
// 'erro' → ocorreu algum problema

const erro = ref('')
// Guarda a mensagem de erro que será apresentada ao usuário


async function iniciarCamera() {

  // Limpa uma mensagem de erro anterior
  erro.value = ''

  // Define novamente o estado como "abrindo"
  status.value = 'abrindo'


  // Verifica se o site está utilizando um contexto seguro
  // HTTPS é necessário para acessar a câmera em dispositivos móveis
  // localhost é permitido durante o desenvolvimento
  if (
    !window.isSecureContext &&
    location.hostname !== 'localhost'
  ) {

    // Altera o estado para erro
    status.value = 'erro'

    // Mensagem apresentada ao usuário
    erro.value =
      'A câmera exige HTTPS no celular. Publique o projeto em HTTPS.'

    // Interrompe a função
    return
  }


  // Verifica se o navegador possui suporte para acessar a câmera
  // getUserMedia() é a API utilizada pelo navegador para solicitar
  // acesso à câmera e ao microfone
  if (!navigator.mediaDevices?.getUserMedia) {

    // Altera o estado para erro
    status.value = 'erro'

    // Mensagem apresentada ao usuário
    erro.value =
      'Este navegador não permite acesso à câmera neste endereço.'

    // Interrompe a função
    return
  }


  try {

    // Solicita acesso à câmera do dispositivo
    const stream = await navigator.mediaDevices.getUserMedia({

      // Informa que queremos utilizar vídeo
      video: {

        // Solicita preferencialmente a câmera traseira
        // "environment" = câmera voltada para o ambiente
        facingMode: {
          ideal: 'environment'
        }
      },

      // Não precisamos utilizar o microfone
      audio: false
    })


    // Percorre as faixas da câmera
    // e encerra o stream utilizado neste teste
    stream.getTracks().forEach(t => t.stop())


    // Aguarda 400 milissegundos
    // antes de continuar para a cena de RA
    await new Promise(r => setTimeout(r, 400))


    // Informa que a câmera foi aberta com sucesso
    status.value = 'ok'


  } catch (e) {

    // Se ocorreu algum erro, muda o estado para "erro"
    status.value = 'erro'


    // Verifica se o usuário negou a permissão da câmera
    erro.value =
      e.name === 'NotAllowedError'
        ? 'Permissão da câmera negada. Permita a câmera nas configurações do navegador e tente novamente.'

        // Verifica se nenhuma câmera foi encontrada
        : e.name === 'NotFoundError'
          ? 'Nenhuma câmera encontrada.'

          // Caso seja outro erro, apresenta o nome do erro
          : `Não foi possível abrir a câmera: ${e.name || e.message}`
  }
}


// onMounted executa iniciarCamera()
// assim que o componente é carregado na página
onMounted(iniciarCamera)

</script>


<template>

  <!--
    Container principal da Realidade Aumentada
  -->
  <div class="ra-overlay">


    <!--
      Botão para fechar a tela de Realidade Aumentada

      @click → executa uma ação quando o botão é clicado

      emit('fechar') → envia o evento "fechar"
      para o componente pai
    -->
    <button
      class="fechar"
      @click="emit('fechar')"
    >
      ✕ Fechar RA
    </button>


    <!--
      Esta área aparece enquanto a câmera
      ainda está abrindo ou quando ocorreu um erro

      v-if="status!=='ok'"
      significa:
      mostrar somente quando status NÃO for "ok"
    -->
    <div
      v-if="status!=='ok'"
      class="camera-status"
    >

      <div>

        <!--
          Se status for "abrindo":
          mostra "Abrindo câmera..."

          Caso contrário:
          mostra mensagem de erro
        -->
        <h2>
          {{
            status === 'abrindo'
              ? '📷 Abrindo câmera...'
              : '⚠️ Não foi possível abrir a câmera'
          }}
        </h2>


        <!--
          v-if verifica se a câmera está sendo aberta

          Enquanto estiver abrindo,
          orienta o usuário a autorizar a câmera
        -->
        <p v-if="status==='abrindo'">
          Autorize o acesso à câmera quando o navegador solicitar.
        </p>


        <!--
          Quando existe erro,
          apresenta a mensagem armazenada na variável erro
        -->
        <p v-else>
          {{ erro }}
        </p>


        <!--
          Este botão aparece somente quando ocorreu erro

          Ao clicar:
          executa novamente a função iniciarCamera()
        -->
        <button
          v-if="status==='erro'"
          class="btn-tentar"
          @click="iniciarCamera"
        >
          Tentar novamente
        </button>

      </div>

    </div>


    <!--
      A-Frame

      <a-scene> representa a cena 3D.

      v-if="status==='ok'"
      significa que a cena somente será criada
      quando a câmera estiver disponível.

      embedded
      → coloca a cena dentro da página.

      vr-mode-ui="enabled:false"
      → desativa a interface de modo VR.

      renderer
      → configura o mecanismo de renderização 3D.

      antialias:true
      → melhora a suavização dos objetos.

      alpha:true
      → permite transparência.

      arjs
      → configura o AR.js.

      sourceType: webcam
      → utiliza a webcam/câmera do dispositivo.

      videoTexture:true
      → utiliza o vídeo da câmera como textura.

      debugUIEnabled:false
      → desativa a interface de depuração do AR.js.
    -->
    <a-scene
      v-if="status==='ok'"
      embedded
      vr-mode-ui="enabled:false"
      renderer="antialias:true; alpha:true"
      arjs="sourceType: webcam; videoTexture:true; debugUIEnabled:false;"
    >


      <!--
        <a-marker>

        Define o marcador utilizado pela Realidade Aumentada.

        preset="hiro"
        → utiliza o marcador HIRO padrão do AR.js.

        smooth="true"
        → ativa o suavizamento do rastreamento do marcador.
      -->
      <a-marker
        preset="hiro"
        smooth="true"
      >


        <!--
          <a-box>

          Cria um objeto 3D em formato de cubo.

          position="0 0.5 0"
          → define a posição do cubo nos eixos X, Y e Z.

          color="#2563eb"
          → define a cor do cubo.

          animation
          → cria uma animação de rotação.

          property:rotation
          → propriedade que será alterada: rotação.

          to:0 360 0
          → gira o objeto 360 graus.

          loop:true
          → repete a animação continuamente.

          dur:5000
          → a rotação dura 5000 milissegundos,
             ou seja, 5 segundos.
        -->
        <a-box
          position="0 0.5 0"
          color="#2563eb"
          animation="property:rotation; to:0 360 0; loop:true; dur:5000"
        >
        </a-box>


        <!--
          <a-text>

          Cria um texto dentro da cena 3D.

          :value
          → o ":" significa que o valor vem do Vue.

          produto.nome
          → nome do produto.

          produto.potencia
          → potência do produto.

          produto.voltagem
          → voltagem do produto.

          produto.preco
          → preço do produto.

          toFixed(2)
          → mantém duas casas decimais.

          replace('.', ',')
          → troca o ponto decimal por vírgula.

          align="center"
          → centraliza o texto.

          position
          → define a posição do texto na cena.

          rotation
          → define a rotação do texto.

          width
          → define a largura do texto.
        -->
        <a-text
          :value="produto.nome + '\n' + produto.potencia + ' | ' + produto.voltagem + '\nR$ ' + produto.preco.toFixed(2).replace('.', ',')"
          color="black"
          *align*="center"
          position="0 1.4 0"
          rotation="-90 0 0"
          width="3"
        >
        </a-text>


      </a-marker>


      <!--
        <a-entity camera>

        Representa a câmera dentro da cena do A-Frame.
      -->
      <a-entity camera>
      </a-entity>


    </a-scene>


    <!--
      Informações apresentadas sobre a Realidade Aumentada.

      v-if="status==='ok'"
      → somente aparece quando a câmera está funcionando.
    -->
    <div
      v-if="status==='ok'"
      class="ra-info"
    >

      <!--
        Mostra o nome do produto recebido pelo componente
      -->
      <strong>
        {{ produto.nome }}
      </strong>


      <!--
        Orientação para o usuário
      -->
      <span>
        📷 Aponte a câmera para o marcador HIRO
      </span>

    </div>


  </div>

</template>