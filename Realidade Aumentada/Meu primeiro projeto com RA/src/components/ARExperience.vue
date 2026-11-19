<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'

defineProps({ experiment: { type: Object, required: true } })

const wrap = ref(null)
const status = ref('checking') // checking | ready | error
const loading = ref(true)
const errorText = ref('')
let unmounted = false

function friendlyError(err) {
  switch (err?.name) {
    case 'NotFoundError':
    case 'OverconstrainedError':
      return 'Nenhuma câmera foi encontrada neste dispositivo.'
    case 'NotAllowedError':
    case 'SecurityError':
      return 'O acesso à câmera foi negado. Libere a permissão no navegador e tente de novo.'
    case 'NotReadableError':
      return 'A câmera está sendo usada por outro programa. Feche-o e tente de novo.'
    default:
      return 'Não foi possível abrir a câmera.'
  }
}

// Confere a câmera ANTES de montar a cena, para mostrar um erro amigável
// em vez do texto cru que o AR.js joga no fim da página.
async function checkCamera() {
  status.value = 'checking'
  loading.value = true
  errorText.value = ''
  if (!navigator.mediaDevices?.getUserMedia) {
    errorText.value = window.isSecureContext
      ? 'Este navegador não oferece acesso à câmera.'
      : 'A câmera só funciona em localhost ou em um endereço HTTPS.'
    status.value = 'error'
    return
  }
  try {
    const stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } })
    stream.getTracks().forEach((track) => track.stop())
    if (unmounted) return
    status.value = 'ready'
  } catch (err) {
    if (unmounted) return
    errorText.value = friendlyError(err)
    status.value = 'error'
  }
}

// O AR.js cria o <video id="arjs-video"> direto no <body>.
// Aqui ele é puxado para dentro do painel, para não cobrir a página.
function moveVideoIntoPanel() {
  const video = document.querySelector('#arjs-video')
  if (video && wrap.value && video.parentNode !== wrap.value) {
    wrap.value.prepend(video)
  }
  loading.value = false
}

// Se a câmera falhar depois de a cena já ter sido montada.
function onCameraError() {
  errorText.value = 'Não foi possível abrir a câmera.'
  status.value = 'error'
}

// O AR.js não limpa nada sozinho: sem isso a câmera continua ligada
// e o vídeo antigo fica na página ao fechar ou trocar de experimento.
function releaseCamera() {
  const video = document.querySelector('#arjs-video')
  if (video) {
    video.srcObject?.getTracks?.().forEach((track) => track.stop())
    video.srcObject = null
    video.remove()
  }
  document.getElementById('error-popup')?.remove()
  wrap.value?.querySelector('a-scene')?.renderer?.dispose?.()
}

onMounted(() => {
  window.addEventListener('arjs-video-loaded', moveVideoIntoPanel)
  window.addEventListener('camera-error', onCameraError)
  checkCamera()
})

onBeforeUnmount(() => {
  unmounted = true
  window.removeEventListener('arjs-video-loaded', moveVideoIntoPanel)
  window.removeEventListener('camera-error', onCameraError)
  releaseCamera()
})
</script>

<template>
  <div class="ar-content">
    <div ref="wrap" class="scene-wrap">
      <a-scene v-if="status === 'ready'" embedded arjs="sourceType: webcam; debugUIEnabled: false;" vr-mode-ui="enabled: false" renderer="logarithmicDepthBuffer: true">
        <a-marker preset="hiro">
          <a-entity v-if="experiment.id === 1" position="0 0.4 0">
            <a-box position="0 0.45 0" material="color: #d69b36; roughness: 0.7"></a-box>
            <a-torus position="0 0.45 0.55" rotation="90 0 0" radius="0.42" radius-tubular="0.045" material="color: #24201b"></a-torus>
            <a-text value="CAMERA / CAM" align="center" position="0 1.2 0" color="#21180f" width="4"></a-text>
          </a-entity>
          <a-entity v-if="experiment.id === 3" position="0 0.5 0">
            <a-sphere position="-0.28 0.45 0" radius="0.22" material="color: #f4e6c9"></a-sphere>
            <a-sphere position="0.28 0.45 0" radius="0.22" material="color: #f4e6c9"></a-sphere>
            <a-sphere position="-0.28 0.45 0.18" radius="0.09" material="color: #17120f"></a-sphere>
            <a-sphere position="0.28 0.45 0.18" radius="0.09" material="color: #17120f"></a-sphere>
            <a-text value="ESTOU DE OLHO" align="center" position="0 1.05 0" color="#21180f" width="4"></a-text>
          </a-entity>
        </a-marker>
        <a-entity camera></a-entity>
      </a-scene>

      <div v-if="status === 'checking' || (status === 'ready' && loading)" class="scene-msg">Abrindo a câmera…</div>

      <div v-if="status === 'error'" class="scene-msg scene-error">
        <strong>{{ errorText }}</strong>
        <button @click="checkCamera">TENTAR DE NOVO</button>
      </div>

      <div v-if="status === 'ready'" class="scene-caption">
        <strong v-if="experiment.id === 1">Veja, você está vendo uma câmera com uma câmera.</strong>
        <strong v-else-if="experiment.id === 2">Se você não está vendo, está funcionando.</strong>
        <strong v-else>Agora a realidade está de olho em você.</strong>
        <span>APONTE PARA O MARCADOR HIRO</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.ar-content{flex:1;min-height:0;padding:8px 0 0}
.scene-wrap{position:relative;width:100%;height:100%;overflow:hidden;background:#17120f;border:5px solid #ead5ad;box-shadow:5px 6px 0 #39291c}
a-scene{position:absolute!important;inset:0;width:100%;height:100%;z-index:1}
.scene-msg{position:absolute;inset:0;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:12px;padding:16px;text-align:center;color:#f6e5c7;font:13px 'Special Elite',serif;letter-spacing:1px;z-index:2;pointer-events:none}
.scene-error{pointer-events:auto}
.scene-error button{background:transparent;color:#efc56f;border:1px dashed #efc56f;padding:8px 16px;font:11px 'Special Elite',serif;letter-spacing:2px;cursor:pointer}
.scene-caption{position:absolute;left:0;right:0;bottom:0;display:flex;flex-direction:column;align-items:center;gap:3px;padding:7px;background:#17120fd9;color:#f6e5c7;text-align:center;font:12px Georgia,serif;pointer-events:none;z-index:3}
.scene-caption span{font:9px 'Special Elite',serif;letter-spacing:2px;color:#efc56f}
</style>
