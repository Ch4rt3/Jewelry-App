# Requerimientos Funcionales
---

| **Identificación del requerimiento** | RF01 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Iniciar sesión |
| **Características**                  | El usuario podrá iniciar sesión a su cuenta |
| **Descripción del requerimiento**     | El usuario podrá iniciar sesión con su correo o número de celular junto con su clave creada. Además, podrá iniciar sesión con Google. Adicionalmente, tendrá las opciones de poder restablecer la contraseña y registrarse |
| **Requerimiento NO funcional**        | - El sistema debe garantizar la protección de los datos de acceso mediante el uso de cifrado. <br> - El tiempo de respuesta para el inicio de sesión no debe exceder los 3 segundos. <br> - El sistema debe permitir el inicio de sesión utilizando autenticación a través de Google. <br> - La aplicación debe ser accesible y estar optimizada para dispositivos Android de versión 6.0 en adelante. <br> - El sistema debe bloquear la cuenta temporalmente después de varios intentos fallidos de inicio de sesión. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF02 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Registrar cuenta |
| **Características**                  | El usuario podrá registrarse para crear una cuenta en la aplicación, proporcionando un correo electrónico, una contraseña, y la confirmación de esta. También podrá registrarse usando su cuenta de Google. |
| **Descripción del requerimiento**     | El usuario podrá registrarse en la aplicación proporcionando los datos solicitados en el formulario de registro: correo electrónico, contraseña y confirmación de la contraseña. Se debe validar que el correo tenga un formato adecuado y que la contraseña cumpla con las normas de seguridad mínimas. El formulario también debe ofrecer la opción de registrarse usando Google. Después de registrarse, el usuario recibirá un correo electrónico para verificar su cuenta y activarla antes de poder iniciar sesión. |
| **Requerimiento NO funcional**        | - El sistema debe cumplir con los estándares de seguridad para el manejo de contraseñas (cifrado y almacenamiento seguro). <br> - El tiempo de respuesta para el registro no debe exceder los 3 segundos. <br> - La interfaz de registro debe ser accesible y estar optimizada para dispositivos móviles Android. <br> - El sistema debe validar que el correo electrónico no esté registrado previamente. <br> - La aplicación debe ser compatible con la autenticación de Google para el registro. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF03 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Restablecer contraseña |
| **Características**                  | El usuario podrá restablecer su contraseña si olvida la actual. |
| **Descripción del requerimiento**     | El usuario podrá iniciar el proceso de restablecimiento de contraseña seleccionando la opción "Olvidé mi contraseña" en la pantalla de inicio de sesión. Se le solicitará que ingrese su correo electrónico registrado, al cual se enviará un enlace para restablecer la contraseña. Al hacer clic en el enlace, el usuario será redirigido a una página donde podrá ingresar una nueva contraseña y confirmarla. |
| **Requerimiento NO funcional**        | - El sistema debe garantizar la seguridad durante el proceso de restablecimiento, utilizando métodos seguros para el envío y recepción de información. <br> - El tiempo de respuesta para procesar la solicitud de restablecimiento de contraseña no debe exceder los 5 segundos. <br> - La interfaz para el restablecimiento de contraseña debe ser accesible y clara para evitar confusiones por parte del usuario. <br> - El sistema debe validar que el correo electrónico ingresado esté asociado con una cuenta existente antes de enviar el enlace de restablecimiento. <br> - El enlace para restablecer la contraseña debe expirar después de un tiempo definido para aumentar la seguridad. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF04 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Cerrar sesión |
| **Características**                  | El usuario podrá cerrar su sesión de manera segura en cualquier momento. |
| **Descripción del requerimiento**     | El usuario tendrá la opción de cerrar sesión desde la interfaz de la aplicación. Al seleccionar la opción de "Cerrar sesión", el sistema deberá invalidar el token de sesión activo y redirigir al usuario a la pantalla de inicio de sesión. Cerrar sesión elimina cualquier información de usuario almacenada temporalmente en el dispositivo, asegurando que la cuenta no pueda ser utilizada sin autorización hasta que se inicie sesión nuevamente. |
| **Requerimiento NO funcional**        | - El sistema debe garantizar que el token de sesión sea invalidado inmediatamente después de cerrar sesión. <br> - El proceso de cierre de sesión debe completarse en menos de 2 segundos. <br> - La interfaz debe ser clara y accesible, mostrando una confirmación visual de que el usuario ha cerrado sesión con éxito. <br> - El sistema debe eliminar cualquier dato temporal o en caché relacionado con la cuenta del usuario después de cerrar sesión. <br> - El sistema debe permitir cerrar sesión en todas las sesiones activas cuando el usuario lo solicite. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF05 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Opciones de usuario |
| **Características**                  | El usuario podrá acceder a diversas opciones relacionadas con su cuenta, como gestionar sus direcciones, ver sus órdenes, administrar su billetera y modificar detalles personales. |
| **Descripción del requerimiento**     | El usuario, desde su perfil, podrá navegar entre distintas opciones que incluyen la gestión de direcciones de envío, la visualización de órdenes anteriores y activas, la administración de la billetera para ver métodos de pago almacenados, y la posibilidad de editar información personal. Estas opciones estarán organizadas de forma clara en una pantalla de perfil dedicada. Cada sección llevará al usuario a pantallas donde podrá ver, editar o añadir información relevante para cada área (como añadir una nueva dirección o revisar los detalles de una orden específica). |
| **Requerimiento NO funcional**        | - El tiempo de carga de las diferentes secciones dentro del perfil (como direcciones, órdenes, billetera) no debe exceder los 2 segundos. <br> - La gestión de métodos de pago en la billetera debe cumplir con estándares de seguridad, como encriptación de datos sensibles y autenticación al agregar o modificar métodos de pago. <br> - Las opciones de usuario deben estar optimizadas para pantallas pequeñas, garantizando una navegación clara e intuitiva en dispositivos móviles. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF06 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Ver perfil |
| **Características**                  | El usuario podrá ver perfil de su cuenta |
| **Descripción del requerimiento**     | El usuario podrá acceder a su perfil desde el menú de navegación de la aplicación. Al acceder a la sección de "Settings", se mostrará la información básica de su cuenta, como nombre, correo electrónico y las opciones para modificar dicha información si es necesario. El usuario también tendrá la opción de cambiar su contraseña desde esta pantalla. Además, se podrá ver la imagen de perfil y actualizarla. |
| **Requerimiento NO funcional**        | - El sistema debe garantizar la seguridad de los datos personales mostrados en el perfil, evitando accesos no autorizados. <br> - El tiempo de carga de la información de perfil no debe exceder los 3 segundos. <br> - La interfaz del perfil debe ser intuitiva y estar optimizada para dispositivos móviles. <br> - El sistema debe validar cualquier modificación en la información personal y solicitar confirmación antes de guardar los cambios. <br> - La imagen de perfil debe actualizarse y mostrarse en tiempo real tras ser modificada por el usuario. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF07 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Ver billetera |
| **Características**                  | El usuario podrá visualizar la información de los métodos de pago guardados en su billetera. |
| **Descripción del requerimiento**     | El usuario podrá acceder a la sección de su billetera desde el menú de perfil. En esta sección, se mostrarán los métodos de pago que el usuario ha guardado previamente, como tarjetas de crédito o débito. El sistema permitirá visualizar el nombre del titular de la tarjeta, los últimos cuatro dígitos del número de tarjeta y la fecha de vencimiento. Además, el usuario tendrá la opción de agregar un nuevo método de pago o eliminar los existentes. La interfaz será intuitiva y permitirá al usuario realizar acciones con facilidad. |
| **Requerimiento NO funcional**        | - El sistema debe garantizar la seguridad de la información de los métodos de pago, encriptando los datos sensibles como los números de tarjetas. <br> - El tiempo de carga de la sección de billetera no debe exceder los 3 segundos. <br> - La interfaz debe ser responsiva y estar optimizada para dispositivos móviles de diferentes tamaños. <br> - Cualquier cambio en la información de los métodos de pago debe ser validado y confirmado antes de guardar los cambios. <br> - El sistema debe actualizar la información de los métodos de pago en tiempo real tras realizar alguna modificación. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF08 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Añadir tarjeta de crédito/débito |
| **Características**                  | El usuario podrá añadir una nueva tarjeta de crédito o débito a su billetera. |
| **Descripción del requerimiento**     | El usuario podrá acceder a la opción "Añadir tarjeta" desde la sección de billetera. Al seleccionar esta opción, se mostrará un formulario donde el usuario deberá ingresar los datos de su tarjeta, tales como el número de tarjeta, nombre del titular, fecha de vencimiento y código de seguridad (CVV). El sistema validará la información introducida para asegurarse de que los datos sean correctos y cumplan con los estándares de seguridad. Una vez agregada, la tarjeta aparecerá en la lista de métodos de pago disponibles. El sistema también permitirá seleccionar si la nueva tarjeta debe ser el método de pago predeterminado. |
| **Requerimiento NO funcional**        | - El sistema debe encriptar la información de la tarjeta antes de almacenarla, garantizando la seguridad de los datos. <br> - El tiempo de validación de la tarjeta no debe exceder los 3 segundos. <br> - La interfaz del formulario debe ser clara, intuitiva y optimizada para dispositivos móviles. <br> - El sistema debe validar que los datos de la tarjeta sean reales y no contengan errores tipográficos antes de guardarlos. <br> - Se deben cumplir con las normativas PCI-DSS para la gestión de datos de tarjetas de crédito/débito. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF09 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Ver órdenes |
| **Características**                  | El usuario podrá ver el historial de sus órdenes, con detalles de cada pedido realizado. |
| **Descripción del requerimiento**     | El usuario podrá acceder a la sección de órdenes desde su perfil. En esta pantalla, se mostrará una lista con las órdenes realizadas por el usuario, organizadas en tres pestañas: "Entregadas", "En proceso" y "Canceladas". Cada orden mostrará información relevante, como el número de pedido, la fecha de compra, la cantidad de productos y el monto total. Al seleccionar una orden específica, el usuario podrá ver los detalles del pedido, incluyendo el estado del envío, los productos adquiridos, y los precios desglosados. También se incluirá la opción de descargar la factura en PDF o realizar un reclamo en caso de problemas con el pedido. |
| **Requerimiento NO funcional**        | - El sistema debe cargar el historial de órdenes en menos de 3 segundos. <br> - La interfaz de la sección de órdenes debe ser responsiva y adaptarse a dispositivos móviles. <br> - Los detalles de la orden deben actualizarse en tiempo real, especialmente el estado de envío. <br> - La información debe estar protegida, y solo el usuario autenticado debe poder acceder a sus propias órdenes. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF10 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Ver direcciones |
| **Características**                  | El usuario podrá ver y gestionar las direcciones de envío guardadas en su cuenta. |
| **Descripción del requerimiento**     | El usuario podrá acceder a la sección de "Direcciones" desde su perfil. En esta pantalla, se listan todas las direcciones de envío que el usuario ha guardado. Para cada dirección, se mostrarán detalles como el nombre del destinatario, la dirección completa, ciudad, estado y código postal. El usuario tendrá la opción de añadir una nueva dirección, editar una existente o eliminar alguna. Además, podrá seleccionar una dirección predeterminada que será utilizada automáticamente en futuras compras. El sistema validará que las direcciones ingresadas sean correctas y completas antes de guardarlas. |
| **Requerimiento NO funcional**        | - El sistema debe garantizar la seguridad y privacidad de las direcciones guardadas, evitando accesos no autorizados. <br> - El tiempo de carga de la sección de direcciones no debe exceder los 2 segundos. <br> - La interfaz debe ser fácil de usar y adaptarse a dispositivos móviles. <br> - El sistema debe validar la integridad de las direcciones ingresadas (por ejemplo, que el formato sea correcto y que el código postal sea válido). <br> - Los cambios en las direcciones deben reflejarse en tiempo real después de que el usuario los guarde. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF11 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Agregar dirección |
| **Características**                  | El usuario podrá añadir una nueva dirección de envío a su cuenta. |
| **Descripción del requerimiento**     | El usuario podrá acceder a la opción "Añadir dirección" en la sección de direcciones dentro de su perfil. Al seleccionarla, se abrirá un formulario donde el usuario podrá ingresar la información requerida, incluyendo nombre del destinatario, dirección completa, ciudad, estado, código postal y un número de teléfono. El sistema validará que todos los campos sean completados y que el formato de la dirección sea correcto. Una vez confirmada la nueva dirección, esta será guardada en la lista de direcciones del usuario y estará disponible para ser seleccionada en futuras compras. El usuario también podrá marcar la nueva dirección como predeterminada si así lo desea. |
| **Requerimiento NO funcional**        | - El sistema debe ser capaz de detectar automáticamente el país y la ciudad del usuario a partir del código postal, para facilitar el llenado del formulario. <br> - El sistema debe ofrecer sugerencias automáticas mientras el usuario escribe la dirección, basándose en servicios de geolocalización o APIs de direcciones. <br> - La nueva dirección debe guardarse en formato estructurado, facilitando búsquedas rápidas y eficientes en el futuro. <br> - El sistema debe poder manejar direcciones internacionales, asegurando compatibilidad con diferentes formatos de direcciones. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF14 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Editar cuenta |
| **Características**                  | El usuario podrá editar la información de su cuenta, como nombre, dirección de correo electrónico, contraseña, dirección de envío y preferencias personales. |
| **Descripción del requerimiento**     | El usuario podrá acceder a la sección de configuración de cuenta desde el menú principal. En esta sección, se le permitirá modificar información personal, como nombre completo, dirección de correo electrónico, dirección de envío, y otros detalles relacionados con su perfil. También podrá cambiar su contraseña. Al guardar los cambios, el sistema actualizará la información en la base de datos. |
| **Requerimiento NO funcional**        | - El tiempo de procesamiento para guardar los cambios en la cuenta no debe superar los 2 segundos. <br> - La interfaz debe guiar al usuario de manera clara y permitir la edición de la cuenta con el mínimo número de pasos posibles. <br> - El sistema debe implementar validaciones robustas para evitar que se ingresen datos incorrectos o mal formateados, como direcciones de correo no válidas o contraseñas débiles. <br> - Las actualizaciones de información de cuenta deben ser compatibles y reflejarse correctamente en otras secciones de la aplicación, como en el checkout y la pantalla de perfil. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF15 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Cambiar configuración |
| **Características**                  | El usuario podrá modificar varias configuraciones relacionadas con su cuenta, como cambiar su contraseña, ajustar preferencias de notificaciones, y gestionar los datos de inicio de sesión. |
| **Descripción del requerimiento**     | El usuario accede a la sección de ‘Configuración’ desde su perfil. En esta pantalla, podrá realizar ajustes como cambiar su contraseña, actualizar su correo electrónico, activar o desactivar notificaciones, y gestionar otros datos importantes como nombre de usuario y preferencia de idioma. Cualquier cambio realizado será guardado de inmediato y se refleja en toda la aplicación. El sistema permitirá una navegación fluida entre estas opciones y ofrecerá confirmación visual de los cambios exitosos, como mensajes de éxito o alertas. |
| **Requerimiento NO funcional**        | - Los cambios realizados en las configuraciones deben sincronizarse automáticamente con la base de datos y reflejarse en todas las plataformas en tiempo real, sin necesidad de reiniciar la aplicación. <br> - El tiempo de respuesta para aplicar cambios no debe exceder los 1.5 segundos para garantizar una experiencia fluida. <br> - Todas las configuraciones, especialmente la actualización de contraseñas y correos electrónicos, deben pasar por un sistema de validación robusto para evitar entradas inválidas. |
| **Prioridad del requerimiento**       | Alta |


| **Identificación del requerimiento** | RF16 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Ver notificaciones |
| **Características**                  | El usuario podrá visualizar las notificaciones dentro de la aplicación, incluyendo actualizaciones sobre pedidos, promociones, y alertas importantes relacionadas con su cuenta. |
| **Descripción del requerimiento**     | El usuario accederá a la sección de notificaciones a través de la pestaña de settings. Las notificaciones aparecerán en el dispositivo móvil y mostrarán notificaciones sobre pedidos (como confirmaciones, envíos y entregas) o nuevas ofertas o descuentos. Las notificaciones estarán organizadas cronológicamente, y se podrá hacer clic en cada una para obtener más detalles o ser redirigido a la sección correspondiente de la aplicación. |
| **Requerimiento NO funcional**        | - El sistema de notificaciones debe estar optimizado para que las alertas lleguen en tiempo real, con un retraso no mayor a 1 segundo desde la generación del evento. <br> - Las notificaciones deben ser accesibles en toda la aplicación y mantenerse sincronizadas en múltiples dispositivos. <br> - La interfaz debe ser clara, sencilla y adaptada para dispositivos móviles de diferentes tamaños. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF17 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Ver catálogo |
| **Características**                  | El usuario podrá explorar y visualizar los productos disponibles en las distintas categorías del catálogo. |
| **Descripción del requerimiento**     | El usuario podrá navegar por el catálogo de la tienda, el cual estará organizado por categorías como "Anillos", "Pulseras", "Collares", "Aretes", y "Hombres". Al seleccionar una categoría, se mostrarán todos los productos disponibles en esa sección, junto con una imagen, nombre y precio. Además, se proporcionarán filtros para ordenar los productos según precio, popularidad, o novedades, y un buscador para localizar productos específicos. |
| **Requerimiento NO funcional**        | - El tiempo de carga del catálogo no debe exceder los 3 segundos al cambiar de categoría o aplicar filtros. <br> - La interfaz del catálogo debe ser accesible y estar optimizada para dispositivos móviles, adaptándose a diferentes resoluciones de pantalla. <br> - Las imágenes del catálogo deben cargarse en alta resolución y adaptarse a diferentes tamaños de pantalla sin pérdida de calidad. <br> - El sistema debe permitir la actualización en tiempo real de la disponibilidad de los productos mostrados en el catálogo. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF18 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Ver detalles del producto |
| **Características**                  | El usuario podrá visualizar información detallada de los productos disponibles en la tienda. |
| **Descripción del requerimiento**     | El usuario podrá seleccionar un producto desde cualquier listado o categoría y será redirigido a una pantalla de detalles del producto. En esta pantalla se mostrará una imagen del producto, su nombre, descripción, precio, disponibilidad en stock, y opciones para añadir el producto al carrito o comprarlo directamente. |
| **Requerimiento NO funcional**        | - El tiempo de carga de la pantalla de detalles del producto no debe exceder los 2 segundos. <br> - La interfaz de detalles del producto debe ser clara, accesible y optimizada para dispositivos móviles. <br> - Las imágenes del producto deben cargarse en alta resolución y adaptarse a diferentes tamaños de pantalla sin pérdida de calidad. <br> - El sistema debe permitir la actualización en tiempo real del stock y precio del producto en función de la disponibilidad. <br> - La aplicación debe soportar múltiples idiomas para los detalles del producto. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF19 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Agregar al carrito |
| **Características**                  | El usuario podrá añadir productos al carrito de compras para proceder con la compra posteriormente. |
| **Descripción del requerimiento**     | El usuario podrá agregar productos a su carrito de compras desde la pantalla de detalles de cada producto o desde los listados de categorías. Al hacer clic en "Agregar al carrito", el sistema almacenará el producto en el carrito junto con la cantidad seleccionada y el precio actual. El usuario podrá visualizar todos los productos añadidos al carrito en la pantalla dedicada y proceder a la compra desde allí. También tendrá la opción de modificar la cantidad de productos o eliminar elementos del carrito. |
| **Requerimiento NO funcional**        | - El tiempo de respuesta al agregar un producto al carrito no debe exceder los 2 segundos. <br> - La interfaz del carrito debe ser clara y optimizada para dispositivos móviles, mostrando una lista de productos fácil de visualizar y modificar. <br> - El sistema debe mantener los productos agregados al carrito incluso si el usuario cierra la aplicación, utilizando almacenamiento temporal o persistente según corresponda. <br> - El sistema debe actualizar en tiempo real la disponibilidad del producto y notificar al usuario si algún producto en el carrito queda fuera de stock antes de proceder con la compra. <br> - La aplicación debe permitir añadir múltiples productos al carrito sin límites, salvo restricciones impuestas por stock. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RF20 |
|--------------------------------------|------|
| **Nombre del Requerimiento**         | Realizar compra |
| **Características**                  | El usuario podrá realizar la compra de productos desde el carrito de la tienda online. El sistema ofrecerá varias opciones de pago y envío, permitiendo completar la transacción de manera segura. |
| **Descripción del requerimiento**     | El usuario seleccionará los productos que desea comprar desde su carrito. Una vez que el usuario esté listo para completar la compra, será dirigido a una pantalla de pago donde se mostrarán los detalles del pedido, incluyendo el resumen de productos, costos de envío, y opciones de pago disponibles. El usuario podrá confirmar la dirección de envío y proceder con el pago. Después de completar la transacción, el sistema generará una confirmación de la orden y enviará una notificación de éxito. |
| **Requerimiento NO funcional**        | - El tiempo de procesamiento de la compra no debe exceder los 3 segundos desde que el usuario presiona el botón de "Realizar pago". <br> - La aplicación debe ofrecer varias pasarelas de pago y garantizar que todos los métodos de pago sean seguros. <br> - La interfaz de la pantalla de compra debe ser intuitiva y accesible en dispositivos móviles de diferentes tamaños de pantalla. <br> - El sistema debe poder actualizar en tiempo real la disponibilidad del stock del producto al momento de la compra. |
| **Prioridad del requerimiento**       | Alta |

## 1. Flutter SDK

Flutter es un framework de código abierto creado por Google que permite a los usuarios crear aplicaciones móviles nativas para iOS y Android.

### Proceso de instalación:

1. **Descargar Flutter SDK** (cualquier versión a partir de la 3.3.0):
   - Visita el sitio oficial de Flutter y descarga el SDK para tu sistema operativo.
   - Extrae el archivo descargado en la ubicación deseada (por ejemplo, `C:\src\flutter` en Windows).

   ![Descarga del SDK de Flutter](./Assets/Imagenes_PM/Flutter%201.png)

2. **Configurar la Ruta**:
   - **En Windows**: Abre el "Panel de Control", ve a "Sistema y Seguridad" > "Sistema" > "Configuración avanzada del sistema". Haz clic en "Variables de entorno" y edita la variable PATH añadiendo la ruta donde extrajiste Flutter.
   - **En macOS y Linux**: Abre el terminal y añade la línea `export PATH="$PATH:[ruta a flutter]/bin"` al archivo `~/.bashrc`, `~/.zshrc`, o el que corresponda.

   ![Configuración de la Ruta](./Assets/Imagenes_PM/Flutter%202.png)

3. **Verificar Instalación**:
   - Ejecuta el siguiente comando: `flutter doctor --android-licenses` en la terminal para verificar la instalación y ver los componentes que faltan.
   - En caso ocurra un error en la descarga, ejecuta la siguiente línea: `git config --global --add safe.directory '*'`.

   ![Verificación de la instalación](./Assets/Imagenes_PM/Flutter%203.png)

## 2. Android Studio

Android Studio es un entorno de desarrollo integrado (IDE) sencillo de utilizar para desarrollar aplicaciones en Flutter, especialmente en Android. Actúa como un lienzo donde se pueden visualizar los cambios realizados a través de Flutter.

### Proceso de instalación:

1. **Descargar Android Studio**:
   - Descarga Android Studio desde su sitio oficial.

   ![Descarga de Android Studio](./Assets/Imagenes_PM/Android%20Studio%201.png)
   ![Instalación de Android Studio](./Assets/Imagenes_PM/Android%20Studio%202.png)

2. **Instalar Android Studio**:
   - Sigue las instrucciones del instalador dependiendo de tu sistema operativo y asegúrate de incluir el Android SDK y el emulador durante la instalación.

   ![Instalación de Android Studio](./Assets/Imagenes_PM/Android%20Studio%203.png)
   ![Configuración de Plugins en Android Studio](./Assets/Imagenes_PM/Android%20Studio%204.png)
   ![Configuración de Plugins en Android Studio](./Assets/Imagenes_PM/Android%20Studio%205.png)
   ![Configuración de Plugins en Android Studio](./Assets/Imagenes_PM/Android%20Studio%206.png)
   ![Configuración de Plugins en Android Studio](./Assets/Imagenes_PM/Android%20Studio%207.png)
   ![Configuración de Plugins en Android Studio](./Assets/Imagenes_PM/Android%20Studio%208.png)

3. **Configurar Android Studio**:
   - Abre Android Studio y ve a "Configuración" > "Plugins". Busca e instala el plugin de Flutter (esto instalará automáticamente el plugin de Dart).

   ![Configuración de Plugins en Android Studio](./Assets/Imagenes_PM/Android%20Studio%209.png)

4. **Configurar un Emulador de Android**:
   - En Android Studio, ve a "AVD Manager" y crea un nuevo dispositivo virtual (emulador) configurado según tus necesidades.

   ![Configuración de Plugins en Android Studio](./Assets/Imagenes_PM/Android%20Studio%2010.png)

## 3. Visual Studio Code (VS Code)

VS Code es un editor de código fuente ligero y muy popular, ideal para desarrollar con Flutter. Es nuestra herramienta principal para interactuar con el código desarrollado en Flutter junto con Android Studio.

### Proceso de instalación:

1. **Descargar VS Code**:
   - Descarga VS Code desde su sitio oficial.

   ![Descarga de VS Code](./Assets/Imagenes_PM/VS%20code%201.png)

2. **Instalar Extensiones de Flutter y Dart**:
   - Abre VS Code y ve a "Extensiones". Busca e instala las extensiones de Flutter y Dart.

   ![Instalación de Extensiones en VS Code](./Assets/Imagenes_PM/VS%20code%202.png)
   ![Configuración de Debugging en VS Code](./Assets/Imagenes_PM/VS%20code%203.png)

3. **Configurar Debugging**:
   - Abre la paleta de comandos (`Ctrl+Shift+P` o `Cmd+Shift+P` en macOS) y ejecuta el comando `Flutter: New Project` para crear un nuevo proyecto Flutter y asegurarte de que todo está configurado correctamente.



# Requerimientos No Funcionales
---

| **Identificación del requerimiento** | RNF 01 |
|--------------------------------------|---------|
| **Nombre del Requerimiento**         | Aplicación será desarrollada en Flutter SDK 3.24 |
| **Características**                  | El usuario podrá acceder a la interfaz de mapa de rutas de las actividades de los itinerarios. |
| **Descripción del requerimiento**     | El usuario podrá visualizar las rutas de las actividades de los itinerarios que ha creado a través de un filtro. En ese filtro, se le pedirá en una casilla el nombre del itinerario en el que se quiere extraer la actividad y seguidamente en otra casilla, el nombre de la actividad que se quiere mostrar en el mapa. Después de colocar los datos necesarios, se contará con un botón de siguiente en el que se actualizará el mapa con la nueva actividad registrada. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RNF 02 |
|--------------------------------------|---------|
| **Nombre del Requerimiento**         | La aplicación será diseñada bajo una paleta de colores |
| **Características**                  | El usuario podrá acceder a la interfaz de mapa de rutas de las actividades de los itinerarios. |
| **Descripción del requerimiento**     | El usuario podrá visualizar las rutas de las actividades de los itinerarios que ha creado a través de un filtro. En ese filtro, se le pedirá en una casilla el nombre del itinerario en el que se quiere extraer la actividad y seguidamente en otra casilla, el nombre de la actividad que se quiere mostrar en el mapa. Después de colocar los datos necesarios, se contará con un botón de siguiente en el que se actualizará el mapa con la nueva actividad registrada. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RNF 03 |
|--------------------------------------|---------|
| **Nombre del Requerimiento**         | La aplicación se desplegará en Android |
| **Características**                  | El usuario podrá acceder a la interfaz de mapa de rutas de las actividades de los itinerarios. |
| **Descripción del requerimiento**     | El usuario podrá visualizar las rutas de las actividades de los itinerarios que ha creado a través de un filtro. En ese filtro, se le pedirá en una casilla el nombre del itinerario en el que se quiere extraer la actividad y seguidamente en otra casilla, el nombre de la actividad que se quiere mostrar en el mapa. Después de colocar los datos necesarios, se contará con un botón de siguiente en el que se actualizará el mapa con la nueva actividad registrada. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RNF 04 |
|--------------------------------------|---------|
| **Nombre del Requerimiento**         | El servidor se desplegará en Replit Server - Ruby |
| **Características**                  | El usuario podrá acceder a la interfaz de mapa de rutas de las actividades de los itinerarios. |
| **Descripción del requerimiento**     | El usuario podrá visualizar las rutas de las actividades de los itinerarios que ha creado a través de un filtro. En ese filtro, se le pedirá en una casilla el nombre del itinerario en el que se quiere extraer la actividad y seguidamente en otra casilla, el nombre de la actividad que se quiere mostrar en el mapa. Después de colocar los datos necesarios, se contará con un botón de siguiente en el que se actualizará el mapa con la nueva actividad registrada. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RNF 05 |
|--------------------------------------|---------|
| **Nombre del Requerimiento**         | La interfaz de la aplicación será visualmente moderna |
| **Características**                  | El usuario podrá acceder a la interfaz de mapa de rutas de las actividades de los itinerarios. |
| **Descripción del requerimiento**     | El usuario podrá visualizar las rutas de las actividades de los itinerarios que ha creado a través de un filtro. En ese filtro, se le pedirá en una casilla el nombre del itinerario en el que se quiere extraer la actividad y seguidamente en otra casilla, el nombre de la actividad que se quiere mostrar en el mapa. Después de colocar los datos necesarios, se contará con un botón de siguiente en el que se actualizará el mapa con la nueva actividad registrada. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RNF 06 |
|--------------------------------------|---------|
| **Nombre del Requerimiento**         | La aplicación debe ser capaz de procesar un catálogo de al menos 20 productos |
| **Características**                  | El usuario podrá acceder a la interfaz de mapa de rutas de las actividades de los itinerarios. |
| **Descripción del requerimiento**     | El usuario podrá visualizar las rutas de las actividades de los itinerarios que ha creado a través de un filtro. En ese filtro, se le pedirá en una casilla el nombre del itinerario en el que se quiere extraer la actividad y seguidamente en otra casilla, el nombre de la actividad que se quiere mostrar en el mapa. Después de colocar los datos necesarios, se contará con un botón de siguiente en el que se actualizará el mapa con la nueva actividad registrada. |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RNF 07 |
|--------------------------------------|---------|
| **Nombre del Requerimiento**         | Ayuda en el uso del sistema |
| **Características**                  | La interfaz del usuario deberá de presentar un sistema de ayuda para que los mismos usuarios del sistema se les facilite el trabajo en cuanto al manejo del sistema. |
| **Descripción del requerimiento**     | La interfaz debe estar complementada con un buen sistema de ayuda (la administración puede recaer en personal con poca experiencia en el uso de aplicaciones informáticas). |
| **Prioridad del requerimiento**       | Alta |

| **Identificación del requerimiento** | RNF 08 |
|--------------------------------------|---------|
| **Nombre del Requerimiento**         | Mantenimiento |
| **Características**                  | El sistema deberá de tener un manual de instalación y manual de usuario para facilitar los mantenimientos que serán realizados por el administrador. |
| **Descripción del requerimiento**     | El sistema debe disponer de una documentación fácilmente actualizable que permita realizar operaciones de mantenimiento con el menor esfuerzo posible. |
| **Prioridad del requerimiento**       | Alta |
