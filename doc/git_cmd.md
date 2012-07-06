#####-- Para iniciar un repositorio en el directorio actual.
    $ git init

#####-- Para visualizar el estatus del repositorio que hemos creado. Es saludable correr este comenado para saber si el repositorio a sufrido algún cambio.
    $ git status

#####-- Añadir un archivo al área de ensayo (staging area) y colocarlo en seguimiento por parte del repositorio
    $ git add <filename>

#####-- También se puede utilizar git add .. El . representa el directorio actual y por tanto todo lo que en él esté así como lo que esté debajo de este.
    $ git add .

#####-- Para eliminar un archivo del área de ensayo (staging area) podemos hacer uso de:
    $ git reset <filename>

#####-- Es bueno saber que los archivos que son añadido "added" están solo en el área de ensayo y no han sido añadido aún al repositorio aún. 
#####-- También se puede hacer uso del comodin * para añadir los archivos al área de ensayo:
    $ git add '*.txt'

#####-- Es bueno luego de esto preguntar el status del repositorio, este nos dirá que hay en el área de ensayo y obviamente luego hacer el commit.
    $ git status
    $ git commit -m "A message to describe the commiting"

#####-- git remote: A Git no le importa lo que usted nombre a sus mandos a distancia, pero es típico el nombre de su principal origen.
#####-- También es una buena idea para su repositorio principal para estar en un servidor remoto como GitHub en caso de pérdida de su máquina en el mar 
#####-- durante un crucero trasatlántico o aplastado por tres estatuas de monos durante un terremoto.
    $ git remote add origin git@github.com:jgabrielsinner10/try_git.git

#####-- Para subir nuestros cambios locales al repositorio github, podemos ejecutar lo siguiente:
    $ git push -u origin master

#####-- El parámetro -u le dice a git que recuerde los parámetros pasados a la función "git push" y la próxima vez solo se deberá ejecutar "git push".
#####-- Con el nombre de "origin" se conoce el repositorio en github.
#####-- Con el nombre de "master" es conocido nuestro repositorio local.
