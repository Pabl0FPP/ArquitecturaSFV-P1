# función para imprimir mensajes con colores
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

# verificar si Docker está instalado
Write-ColorOutput Green "Verificando si Docker está instalado..."
if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-ColorOutput Red "Error: Docker no está instalado o no está en el PATH"
    exit 1
}
Write-ColorOutput Green "✓ Docker está instalado correctamente"

# construir la imagen
Write-ColorOutput Green "`nConstruyendo la imagen Docker..."
try {
    docker build -t mi-app-node .
    Write-ColorOutput Green "✓ Imagen construida exitosamente"
} catch {
    Write-ColorOutput Red "Error: No se pudo construir la imagen Docker"
    exit 1
}

# verificar si el puerto 8080 está en uso
$portInUse = Get-NetTCPConnection -LocalPort 8080 -ErrorAction SilentlyContinue
if ($portInUse) {
    Write-ColorOutput Yellow "Puerto 8080 está en uso. Deteniendo contenedores existentes..."
    docker stop $(docker ps -q) 2>$null
}

# ejecutar el contenedor
Write-ColorOutput Green "`nIniciando el contenedor..."
try {
    docker run -d -p 8080:3000 -e PORT=8080 -e NODE_ENV=production --name mi-app-node-container mi-app-node
    Write-ColorOutput Green "✓ Contenedor iniciado exitosamente"
} catch {
    Write-ColorOutput Red "Error: No se pudo iniciar el contenedor"
    exit 1
}

# esperar a que la aplicación esté lista
Write-ColorOutput Green "`nEsperando a que la aplicación esté lista..."
Start-Sleep -Seconds 5

# realizar prueba básica
Write-ColorOutput Green "`nRealizando prueba de conectividad..."
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080/health" -UseBasicParsing
    if ($response.StatusCode -eq 200) {
        Write-ColorOutput Green "✓ La aplicación está respondiendo correctamente"
        Write-ColorOutput Green "`nResumen del estado:"
        Write-ColorOutput Green "- Docker instalado: SI"
        Write-ColorOutput Green "- Imagen construida: SI"
        Write-ColorOutput Green "- Contenedor ejecutando: SI"
        Write-ColorOutput Green "- Aplicación respondiendo: SI"
        Write-ColorOutput Green "`n¡Despliegue completado con éxito!"
    } else {
        throw "La aplicación no respondió con estado 200"
    }
} catch {
    Write-ColorOutput Red "Error: La aplicación no está respondiendo correctamente"
    Write-ColorOutput Red "Deteniendo el contenedor..."
    docker stop mi-app-node-container
    exit 1
} 