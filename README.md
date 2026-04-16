# AUY1105-grupo-3
-El objetivo de este repositorio es utilizar herramientas de verificación y validación de la App, a traves de GitHub Actions que permite la automatización de estas herramientas Esto permite cumplir con los estandares de calidad de la aplicación de seguridad, calidad y buenas practicas como Infraestructura como Código.

-La infraestructura de AWS que se encuentra en los archivos de terraform (.tf) contiene 4 subredes, en la cual una de ellas tiene una instancia EC2. Tambien esta todo modulado para mejorar la revisión de los archivos tf.

-Para el uso del Workflow se necesita crear los archivos que contengan las herramientas que analizaran los archivos dentro del repositorio. Ya con eso configurado, cualquier modificación que se haga dentro de los archivos del repositorio el workflow empezara un Job que verifica los archivos terraform para poder validar que el codigo no tenga errores o alguna vulnerabilidad. 

-Dando como proposito general el tener conocimiento sobre buenas practicas y permitir un flujo de trabajo mas optimizado y de calidad.
