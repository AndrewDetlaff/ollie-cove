const CACHE_NAME = 'ollie-cove-v1';

self.addEventListener('install', (event) => {
    self.skipWaiting();
});

self.addEventListener('activate', (event) => {
    event.waitUntil(self.clients.claim());
});

self.addEventListener('notificationclick', (event) => {
    event.notification.close();
    const targetUrl = (event.notification.data && event.notification.data.url) || './index.html';
    event.waitUntil(
        self.clients.matchAll({ type: 'window', includeUncontrolled: true }).then((clientList) => {
            for (const client of clientList) {
                if ('focus' in client) {
                    return client.focus();
                }
            }
            if (self.clients.openWindow) {
                return self.clients.openWindow(targetUrl);
            }
        })
    );
});

self.addEventListener('push', (event) => {
    let data = { title: '🦦 Ollie Cove', body: 'Memento de la Ollie!' };
    try {
        if (event.data) {
            data = Object.assign(data, event.data.json());
        }
    } catch (e) {
        if (event.data) {
            data.body = event.data.text();
        }
    }
    event.waitUntil(
        self.registration.showNotification(data.title, {
            body: data.body,
            icon: './ollie-icon.ico',
            badge: './ollie-icon.ico',
            vibrate: [180, 80, 180],
            data: { url: './index.html' }
        })
    );
});
