# Integrando o Magalu Cloud Container Registry com um Cluster Kubernetes

## Introdução

Um container registry é um serviço que armazena e distribui imagens de contêiner. Ele permite que os desenvolvedores armazenem, gerenciem e implantem imagens de contêiner de maneira eficiente e segura. Registries de contêiner são essenciais para a automação de pipelines de CI/CD e para a escalabilidade de aplicações em ambientes de produção.

## 0. Autenticando na conta

```sh
mgc auth login
```

## 1. Criando um cluster de teste

```sh
kind create cluster
```

## 2. Criando um container registry

```sh
mgc container-registry registries create --name=nataliagranato.xyz
```

## 3. Listando o registry

```sh
mgc container-registry registries list
```

## 4. Obtendo as credenciais

```sh
mgc container-registry credentials list
```

Credenciais:

- email: <natalia.gassis@luizalabs.com>
- password: "SEU_PASSWORD"
- username: SEU USUÁRIO

## 5. Construindo a imagem

```sh
docker build -t fastapi:v1.0.0 .
```

## 6. Login no Docker

```sh
docker login https://container-registry.br-se1.magalu.cloud
```

## 7. Taggeando uma imagem

```sh
docker tag fastapi:v1.0.0 container-registry.br-se1.magalu.cloud/nataliagranato.xyz/fastapi:v1.0.0
```

## 8. Enviando a imagem para o registro remoto

```sh
docker push container-registry.br-se1.magalu.cloud/nataliagranato.xyz/fastapi:v1.0.0
```

## 9. Criando uma secret no Kubernetes com as credenciais para utilização da imagem de container

```sh
kubectl create secret docker-registry magalu-registry-secret \
    --docker-server=<url-do-seu-registro> \
    --docker-username=<seu-nome-de-usuario> \
    --docker-password=<sua-senha> \
    --docker-email=<seu-email>
```

## 10. Aplicando os manifestos e acessando a aplicação

```sh
kubectl apply -f .
```
