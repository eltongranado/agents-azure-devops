#!/bin/bash

export JAVA_TOOL_OPTIONS="--add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED"

# Verificar se o argumento de nome da conexão foi fornecido
if [ "$1" ]; then
    connection_name="$1"
    sql_script="$2"
    parameter="$3"
    config_file="/azp/connections/connections.json"

    if [ -f "$config_file" ]; then
        # Extrair as informações de conexão com base no nome da conexão fornecido
        username=$(jq -r ".databases[] | select(.database == \"$connection_name\") | .username" $config_file)
        password=$(jq -r ".databases[] | select(.database == \"$connection_name\") | .password" $config_file)
        host=$(jq -r ".databases[] | select(.database == \"$connection_name\") | .host" $config_file)
        port=$(jq -r ".databases[] | select(.database == \"$connection_name\") | .port" $config_file)
        service_name=$(jq -r ".databases[] | select(.database == \"$connection_name\") | .service_name" $config_file)
        
        # Verificar se encontrou uma correspondência para o nome da conexão
        if [ -z "$username" ]; then
            echo "Conexão com o nome '$connection_name' não encontrada no arquivo de configuração."
            exit 1
        fi

        # Construir o comando SQLcl
        sqlcl_cmd="sql $username/$password@$host:$port/$service_name @$sql_script $parameter"

        # Executar o comando SQLcl
        $sqlcl_cmd
    else
        echo "O arquivo de configuração não foi encontrado."
    fi
else
    echo "Você deve fornecer o nome da conexão como argumento."
fi