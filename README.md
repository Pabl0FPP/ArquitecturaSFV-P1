# ArquitecturaSFV-P1

# Evaluación Práctica - Ingeniería de Software V

## Información del Estudiante
- **Nombre: Pablo Fernando Pineda Patiño**
- **Código: A00395831**
- **Fecha: 06/08/2025**

## Resumen de la Solución
Este proyecto implementa una aplicación Node.js simple contenerizada usando Docker. La solución incluye:
- Una aplicación web básica con endpoints para información
- Un Dockerfile para el despliegue
- Un script de automatización en PowerShell para facilitar el despliegue

## Dockerfile
1. Empezamos usando una imagen base de Node.js versión 18, que ya tiene todo lo necesario para ejecutar apps de Node.js.
2. Creamos y nos movemos a un directorio llamado /app dentro del contenedor, que es donde estara la app.
3. Copiamos los archivos package.json(que contienen la lista de dependencias) al contenedor.
4. Ejecutamos npm install para instalar todas las dependencias necesarias.
5. Copiamos todo el código de nuestra app al contenedor.
6. Indicamos que nuestra app usará el puerto 3000.
7. Finalmente, configuramos el comando que iniciará la app, que es npm start.

## Script de Automatización
El script `deploy.ps1` automatiza completamente el proceso de despliegue:

1. **Verificación de Prerequisitos**
   - Comprueba si Docker está instalado en el sistema
   - Verifica la disponibilidad del puerto 8080

2. **Construcción y Despliegue**
   - Construye la imagen Docker automáticamente
   - Configura las variables de entorno (PORT=8080, NODE_ENV=production)
   - Ejecuta el contenedor con la configuración apropiada

3. **Validación**
   - Realiza pruebas de conectividad al endpoint /health
   - Verifica que el servicio responde correctamente
   - Proporciona un resumen detallado del estado del despliegue

4. **Manejo de Errores**
   - Detecta y maneja fallos en cada paso
   - Proporciona mensajes claros sobre errores
   - Realiza limpieza en caso de fallos

## Principios DevOps Aplicados
1. **Automatización**
   - Script automatizado para el despliegue
   - Eliminación de pasos manuales propensos a errores

2. **Contenerización**
   - Aplicación empaquetada en contenedor Docker
   - Entorno aislado y reproducible

3. **Monitoreo y Feedback**
   - Verificación automática del estado de la aplicación
   - Mensajes claros sobre el estado del despliegue
   - Detección temprana de problemas

## Captura de Pantalla
![Captura de pantalla de la aplicación en Docker](https://i.ibb.co/0VcRkg4B/Captura-de-pantalla-2025-08-06-084246.png)


## Mejoras Futuras
1. **Integración Continua**
   - Implementar pipeline de CI/CD
   - Automatizar pruebas unitarias

2. **Monitoreo Avanzado**
   - Agregar métricas de rendimiento
   - Configurar alertas automáticas

3. **Seguridad**
   - Escaneo de vulnerabilidades en contenedores
   - Implementar secrets management

## Instrucciones para Ejecutar
1. Asegúrate de tener Docker instalado en tu sistema
2. Clona este repositorio
3. Abre PowerShell en el directorio del proyecto
4. Ejecuta el script de despliegue:
   ```powershell
   .\deploy.ps1
   ```
5. Accede a la aplicación en:
   - http://localhost:3000 - Endpoint principal
   - http://localhost:3000/health
