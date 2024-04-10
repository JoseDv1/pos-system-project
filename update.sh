#!/bin/bash

# Actualiza el repositorio principal y todos los submódulos 	
echo "Actualizando repositorio principal"
git pull --recurse-submodules
if [ $? -ne 0 ]; then
    echo "Error al actualizar el repositorio principal"
    exit 1
fi

# Actualiza todos los submódulos
echo "Actualizando submódulos de Cliente y Servidor"
git submodule update --remote --recursive 
if [ $? -ne 0 ]; then
    echo "Error al actualizar los submódulos"
    exit 1
fi

# Cambia a main en todos los submódulos
echo "Cambiando a main en todos los submódulos"
git submodule foreach git checkout main
if [ $? -ne 0 ]; then
    echo "Error al cambiar a main en los submódulos"
    exit 1
fi

# Luego reconstruye el proyecto
echo "Reconstruyendo el proyecto"
docker compose --file './docker-compose.yml' build
if [ $? -ne 0 ]; then
    echo "Error al reconstruir el proyecto"
    exit 1
fi

# Fin del script
echo "¡Actualización completada!"