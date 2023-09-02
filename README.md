**Deutsche eMark**

https://github.com/validierungcc/eMark-v1-docker

https://deutsche-emark.org/


minimal example docker-compose.yml

     ---
     version: '3.9'
     services:
         emark:
             container_name: emark-v1
             image: vfvalidierung/deutsche_emark-v1:1.6.1.1
             restart: unless-stopped
             ports:
                 - '5556:5556'
                 - '127.0.0.1:6666:6666'
             volumes:
                 - 'emark-v1:/emark/.eMark'

     volumes:
        emark-v1:


**RPC Access**

    curl --user 'emarkv1rpc:<password>' --data-binary '{"jsonrpc":"2.0","id":"curltext","method":"getinfo","params":[]}' -H "Content-Type: application/json" http://127.0.0.1:6666
