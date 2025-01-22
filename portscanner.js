const net = require('net');

/**
 * Scans a given range of ports on a host.
 * @param {string} host - The target host (e.g., '127.0.0.1').
 * @param {number} startPort - Starting port number.
 * @param {number} endPort - Ending port number.
 */
async function portScanner(host, startPort, endPort) {
    console.log(`Scanning ports ${startPort}-${endPort} on ${host}...`);
    
    for (let port = startPort; port <= endPort; port++) {
        new Promise((resolve) => {
            const socket = new net.Socket();
            socket.setTimeout(1000); // 1-second timeout

            socket.connect(port, host, () => {
                console.log(`Port ${port} is open`);
                socket.destroy();
                resolve();
            });

            socket.on('error', () => {
                socket.destroy();
                resolve();
            });

            socket.on('timeout', () => {
                socket.destroy();
                resolve();
            });
        });
    }

    console.log('Scan complete.');
}

const targetHost = 'bitex-it.com';
const start = 1;
const end = 10000;

portScanner(targetHost, start, end);

