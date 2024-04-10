:: Actualiza el repositorio principal y todos los submódulos 	
echo "Actualizando repositorio principal"
git pull --recurse-submodules
IF %ERRORLEVEL% NEQ 0 (
    echo "Error al actualizar el repositorio principal"
    EXIT /B %ERRORLEVEL%
)

:: Actualiza todos los submódulos
echo "Actualizando submódulos de Cliente y Servidor"
git submodule update --remote --recursive 
IF %ERRORLEVEL% NEQ 0 (
    echo "Error al actualizar los submódulos"
    EXIT /B %ERRORLEVEL%
)

:: Cambia a main en todos los submódulos
echo "Cambiando a main en todos los submódulos"
git submodule foreach git checkout main
IF %ERRORLEVEL% NEQ 0 (
    echo "Error al cambiar a main en los submódulos"
    EXIT /B %ERRORLEVEL%
)

:: Luego reconstruye el proyecto
echo "Reconstruyendo el proyecto"
docker compose  -f '.\docker-compose.yml' build
IF %ERRORLEVEL% NEQ 0 (
    echo "Error al reconstruir el proyecto"
    EXIT /B %ERRORLEVEL%
)

:: Fin del script
echo "¡Actualización completada!"