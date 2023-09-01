**Deutsche eMark**

https://github.com/validierungcc/eMark-docker

https://deutsche-emark.org/


minimal example docker-compose.yml

     ---
    version: '3.9'
    services:
        emark:
            container_name: emark
            image: vfvalidierung/deutsche_emark:latest
            restart: unless-stopped
            ports:
                - '4555:4555'
                - '127.0.0.1:4444:4444'
            volumes:
                - 'emark:/emark/.eMark'
    volumes:
       emark:

**RPC Access**

    curl --user 'emarkrpc:<password>' --data-binary '{"jsonrpc":"2.0","id":"curltext","method":"getinfo","params":[]}' -H "Content-Type: application/json" http://127.0.0.1:4444
