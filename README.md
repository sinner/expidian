Expidian
========

Developer Team:

Anarai Aguilar
Andreina de Freites
Jehish Loor
José Gabriel González

Expidian is a Project that our Database Teacher's sent our group. 
This app have the object of manage the time live of a court documents.

Check to see if you have a ``vendor/`` directory. If you don't, or if that directory is empty, run the following:

    php bin/vendors install

Next of this you need to configure the app/config/parameter.ini for set user and password of your database conection.

Take the db/expidian_db.sql and create the database from this SQL Satatements File's. This app was developed for PostgreSQL 9.1.

To Configure Production Environment on a Windows PC select the link and follow the steps:

https://tupacamarufreesoftware.wordpress.com/2012/04/25/symfony2-y-su-configuracion-con-wamp-2-2/

If we have our web server on unix OS Follow this steps:

Debes Instalar las librerías SQLite3, INTL y APC ejecutando este comando en el shell:

       sudo apt-get install php-pear php5-dev sqlite php5-sqlite libpcre3-dev php-intl

Y además (Por si falla la instalación de php-intl)

       sudo pecl install intl

       sudo pecl install apc

Luego de instalar estas librerías debes habilitarlas en el archivo php.ini, para esto busca en el archivo php.ini la sección de "extensions" (Ctrl+f) y añadir allí estas líneas:

       extension=apc.so

       extension=intl.so

Y luego añadir o sustituir en la sección de "date.timezone" (Ctrl+f) esta línea:

       date.timezone = 'America/Caracas'

En el mismo archivo php.ini busca la sección de "short_open_tag" (Ctrl+f)y colocala en off

Luego de todo esto debes reiniciar el servidor web (Si usas apache en ubuntu) se hace de esta forma:

       sudo /etc/init.d/apache2 restart

O en otros OS u otros servidor web ejecuta (Pero, este seguro no lo utilices, debes estar utilizando apache):

       sudo /etc/init.d/httpd restart 

Tenemos que darle permisos de escritura a Symfony en los directorios app/chache y app/logs ejecutando el siguiente comando

       sudo chmod 777 -R app/cache
       sudo chmod 777 -R app/logs

