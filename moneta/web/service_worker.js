let CURRENT_VERSION = '1.0.7';  // Atualize manualmente se necessário
const CACHE_NAME = 'cache-v' + CURRENT_VERSION;
const urlsToCache = [
  '/',
  '/index.html',
  '/main.dart.js',
  '/manifest.json'
  //'/version.json'
  // Adicione outras URLs que você deseja armazenar em cache
];

// Install event
self.addEventListener('install', event => {
  self.skipWaiting(); // Ativa imediatamente o novo service worker
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        return cache.addAll(urlsToCache);
      })
  );
});

// Activate event
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => self.clients.claim()) // Força o novo Service Worker a assumir controle imediato dos clientes
  );
});

// Fetch event
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        return response || fetch(event.request);
      })
  );
});

// Handler para mensagens enviadas pelo cliente
self.addEventListener('message', async (event) => {
  if (event.data === 'checkForUpdate') {
    try {
      const response = await fetch('/version.json');
      const versionData = await response.json();

      if (versionData.version !== CURRENT_VERSION) {
        await self.skipWaiting(); // Força o Service Worker a ativar imediatamente
        self.registration.update(); // Atualiza o service worker para carregar a nova versão
        event.source.postMessage('updateFound');
      } else {
        console.log('Nenhuma nova versão detectada');
      }
    } catch (error) {
      console.error('Falha ao verificar atualização:', error);
    }
  }
});

// // Verificação de atualizações periódicas
// setInterval(() => {
//   console.log('Verificando atualizações do Service Worker... ', CURRENT_VERSION);
//   self.registration.update();
// }, 60 * 3000); // Verifica por atualizações a cada 3 minutos
