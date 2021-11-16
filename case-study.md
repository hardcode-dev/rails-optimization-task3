#### Setup
в начале когда я разворачивал проект
я столкнулся с проблемами `mimemagic`
помогло
```bash
HOMEBREW_NO_AUTO_UPDATE=1 brew install shared-mime-info
bundle update mimemagic
```
дальше я решил развернуть постгрес и pghero но все через docker
```yaml
version: "3"
services:
  db:
    image: postgres:14.0-alpine
    ports:
      - 5432:5432
    volumes:
      - ./tmp/postgres_data:/var/lib/postgresql/data
      - ./docker/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d
    environment:
      - POSTGRES_PASSWORD=password
  pghero:
    image: ankane/pghero
    ports:
      - 8080:8080
    depends_on:
      - db
    environment:
      - DATABASE_URL=postgres://postgres:password@db:5432/task_3_development
```

 
