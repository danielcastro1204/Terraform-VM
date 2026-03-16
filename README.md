## Procedimiento de despliegue de una máquina virtual Linux en Azure con Terraform

## Daniel Alejandro Castro Escobar - A00398005

### 1. Estructura de los archivos de configuración


El primer paso consiste en definir la infraestructura como código mediante Terraform. Para este propósito, se crean los siguientes archivos:

- **`main.tf`**: Configura el proveedor `azurerm` y orquesta la infraestructura mediante módulos: grupo de recursos, red, IP pública, NIC y máquina virtual.  
  ![Archivo main.tf](images/Image1.png)

- **`variables.tf`**: Declara las variables de entrada necesarias, como `location`, `admin_username` y `admin_password` (sensible).  
  ![Archivo variables.tf](images/Image2.png)

- **`terraform.tfvars`**: Asigna valores concretos a las credenciales de administrador y otras variables.  
  ![Archivo terraform.tfvars](images/Image3.png)

- **`outputs.tf`**: Define las salidas: la IP pública de la VM y el comando SSH para conectarse.  
  ![Archivo outputs.tf](images/Image4.png)

- **Módulos (`modules/`)**: Contiene submódulos reutilizables que encapsulan recursos específicos:
  - **`resource_group`**: crea el grupo de recursos.
  - **`network`**: red virtual, subred y grupo de seguridad de red (NSG).
  - **`public_ip`**: dirección IP pública.
  - **`nic`**: interfaz de red, con asociación opcional al NSG.
  - **`vm`**: máquina virtual Linux.

Esta organización modular facilita el mantenimiento, la reutilización y la claridad del código, manteniendo separada la configuración de los valores sensibles.

### 2. Inicialización del entorno


Una vez definida la infraestructura, se ejecuta el siguiente comando.

```bash
terraform init
```

Que descarga el proveedor de Azure (`azurerm`) y prepara el directorio de trabajo, creando el archivo de bloqueo y el directorio `.terraform`.

### 3. Despliegue inicial


Al ejecutar `terraform apply`, Terraform muestra el plan de creación de recursos y se confirma con `yes`. Al finalizar el despliegue, Terraform imprime las salidas definidas: la IP pública asignada y el comando SSH para acceder a la máquina virtual. Se intenta conectar a la VM mediante:

```bash
ssh danielcastro@23.102.125.172
```

Sin embargo, la conexión falla con el mensaje `Permission denied`, a pesar de introducir correctamente la contraseña que fue definida en el archivo de configuración.

![Error obtenido](images/Image5.png)

### 4. Diagnóstico del error

Para identificar la causa del problema, se realiza una prueba de conectividad al puerto 22 desde PowerShell:

```bash
Test-NetConnection -ComputerName 23.102.125.172 -Port 22
```

El resultado indica `TcpTestSucceeded : True`, confirmando que el puerto 22 se encuentra abierto y accesible.

### 5. Solución

Explorando otras posibles razones del error, se determina que la causa de que no reconozca la contraseña podría deberse a que esta incluye un caracter que no se incluye en el inglés estándar, por lo que el proceso de creación de la VM en Azure podría no interpretarlo correctamente. Para esto, se decide destruir la máquina virtual generada con `terraform destroy` y levantarla nuevamente con una contraseña nueva que sí cumpla los requisitos de Azure. La contraseña es agregada en el archivo `terraform.tfvars`.

Tras este ajuste, se ejecuta `terraform apply` y la infraestructura se despliega nuevamente sin errores. Finalmente, se utiliza el comando SSH proporcionado por Terraform para acceder a la máquina virtual, introduciendo la nueva contraseña y logrando la conexión sin inconvenientes. De esta manera, se confirma que el problema quedó resuelto y el despliegue funciona correctamente.

![Acceso a la VM](images/Image6.png)

### 6. Verificación

Se accede al portal de Azure y se inspecciona el apartado de las VMs. Allí se confirma la presencia de la VM recién levantada.

![VM en Azure Portal](images/Image7.png)