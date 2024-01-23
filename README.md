# Repositório de Agentes Azure DevOps

Este repositório foi criado com o objetivo de organizar e gerenciar os agentes do Azure DevOps. Aqui você encontrará informações e configurações relacionadas à construção e execução de agentes em contêineres Docker. 

Vamos começar com a configuração de um agente para Docker.

## Docker Build

O primeiro passo para configurar um agente no Azure DevOps é criar uma imagem Docker que contém todas as ferramentas e dependências necessárias. Você pode fazer isso com o comando a seguir:

```bash
docker build --no-cache -t "agent-linux:ubuntu" .

docker run -e AZP_URL="https://dev.azure.com/<organization>/" -e AZP_TOKEN="<token>" -e AZP_POOL="Docker Agent - Linux" -e AZP_AGENT_NAME="agent-linux-ubuntu" --name "agent-linux-ubuntu" agent-linux:ubuntu

docker exec -it agent-linux-ubuntu bash