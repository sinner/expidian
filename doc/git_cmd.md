#####-- Para iniciar un repositorio en el directorio actual.
    $ git init

#####-- Para visualizar el estatus del repositorio que hemos creado. Es saludable correr este comenado para saber si el repositorio a sufrido alg�n cambio.
    $ git status

#####-- A�adir un archivo al �rea de ensayo (staging area) y colocarlo en seguimiento por parte del repositorio
    $ git add <filename>

#####-- Tambi�n se puede utilizar git add .. El . representa el directorio actual y por tanto todo lo que en �l est� as� como lo que est� debajo de este.
    $ git add .

#####-- Para eliminar un archivo del �rea de ensayo (staging area) podemos hacer uso de:
    $ git reset <filename>

#####-- Es bueno saber que los archivos que son a�adido "added" est�n solo en el �rea de ensayo y no han sido a�adido a�n al repositorio a�n. Tambi�n se puede hacer uso del comodin * para a�adir los archivos al �rea de ensayo:
    $ git add '*.txt'

#####-- Es bueno luego de esto preguntar el status del repositorio, este nos dir� que hay en el �rea de ensayo y obviamente luego hacer el commit.
    $ git status
    $ git commit -m "A message to describe the commiting"

#####-- git remote: A Git no le importa lo que usted nombre a sus mandos a distancia, pero es t�pico el nombre de su principal origen. Tambi�n es una buena idea para su repositorio principal para estar en un servidor remoto como GitHub en caso de p�rdida de su m�quina en el mar durante un crucero trasatl�ntico o aplastado por tres estatuas de monos durante un terremoto.
    $ git remote add origin git@github.com:jgabrielsinner10/try_git.git

#####-- Para subir nuestros cambios locales al repositorio github, podemos ejecutar lo siguiente:
    $ git push -u origin master

#####-- El par�metro -u le dice a git que recuerde los par�metros pasados a la funci�n "git push" y la pr�xima vez solo se deber� ejecutar "git push". Con el nombre de "origin" se conoce el repositorio en github. Con el nombre de "master" es conocido nuestro repositorio local.
