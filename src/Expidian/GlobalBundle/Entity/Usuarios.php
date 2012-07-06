<?php

namespace Expidian\GlobalBundle\Entity;

use Symfony\Component\Security\Core\User\UserInterface;

use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Bridge\Doctrine\Validator\Constraints as DoctrineAssert;

use Expidian\GlobalBundle\Entity\Personas;
use Expidian\GlobalBundle\Entity\Perfiles;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Usuarios
 *
 * @DoctrineAssert\UniqueEntity(fields="usuario", message="Este usuario ya existe en la base de datos.")
 * 
 * @ORM\Table(name="usuarios")
 * @ORM\Entity(repositoryClass="Expidian\GlobalBundle\Entity\Repository\UsuariosRepository")
 */
class Usuarios
{
    /**
     * @var integer $idUsuario
     * 
     * @Assert\Regex(pattern="/^0*[1-9][0-9]*$/" , message="El valor {{ value }} no es un {{ type }} válido.") 
     *
     * @ORM\Column(name="id_usuario", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="usuarios_id_usuario_seq", allocationSize="1", initialValue="1")
     */
    private $idUsuario;

    /**
     * @var string $usuario
     * 
     * @Assert\NotBlank(message="El usuario es necesario para tener acceso al sistema.")
     * @Assert\Regex(pattern="/^0*[1-9][0-9]*$/" , message="El valor {{ value }} no es un {{ type }} válido.") 
     * 
     * @ORM\Column(name="usuario", type="string", length=15, nullable=false, unique=true)
     */
    private $usuario;

    /**
     * @var string $usuarioEncrypt
     *
     * @ORM\Column(name="usuario_encrypt", type="string", length=128, nullable=false)
     */
    private $usuarioEncrypt;

    /**
     * @var string $clave
     * 
     * @Assert\NotBlank(message="Debe Ingresar una clave. No se han obtenido algunos datos indispensables para seguir con la operaci&oacute;n.")
     * 
     * @ORM\Column(name="clave", type="string", length=128, nullable=false)
     */
    private $clave;

    /**
     * @var string $esActivo
     * 
     * @Assert\NotBlank(message="Debe Ingresar una clave. No se han obtenido algunos datos indispensables para seguir con la operaci&oacute;n.")
     * @Assert\Choice(choices = {"SI", "NO"}, message = "Debe Seleccionar un Valor Válido.")
     *
     * @ORM\Column(name="es_activo", type="string", length=2, nullable=false)
     */
    private $esActivo;

    /**
     * @var date $fechaRegistro
     *
     * @ORM\Column(name="fecha_registro", type="date", nullable=false)
     */
    private $fechaRegistro;

    /**
     * @var datetime $fechaUltimoIngreso
     *
     * @ORM\Column(name="fecha_ultimo_ingreso", type="date", nullable=true)
     */
    private $fechaUltimoIngreso;

    /**
     * @var Perfiles
     * 
     * @Assert\NotBlank(message="Debe seleccionar un perfil para el Usuario.")
     * @Assert\Type(type="Expidian\GlobalBundle\Entity\Perfiles")
     * 
     * 
     * @ORM\ManyToOne(targetEntity="Perfiles")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_perfil", referencedColumnName="id_perfil")
     * })
     */
    private $perfil;

    /**
     * @var Personas
     * 
     * @Assert\NotBlank(message="Debe ingresar los datos generales del usuario.")
     * @Assert\Type(type="Expidian\GlobalBundle\Entity\Personas")
     * 
     * @ORM\ManyToOne(targetEntity="Personas")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_persona", referencedColumnName="id_persona")
     * })
     */
    private $persona;

    function __construct() {
        
    }

        /**
     * Get idUsuario
     *
     * @return integer 
     */
    public function getIdUsuario()
    {
        return $this->idUsuario;
    }

    /**
     * Set usuario
     *
     * @param string $usuario
     */
    public function setUsuario($usuario)
    {
        $this->usuario = $usuario;
    }

    /**
     * Get usuario
     *
     * @return string 
     */
    public function getUsuario()
    {
        return $this->usuario;
    }

    /**
     * Set usuarioEncrypt
     *
     * @param string $usuarioEncrypt
     */
    public function setUsuarioEncrypt($usuarioEncrypt)
    {
        $this->usuarioEncrypt = hash("sha512",$usuarioEncrypt);
    }

    /**
     * Get usuarioEncrypt
     *
     * @return string 
     */
    public function getUsuarioEncrypt()
    {
        return $this->usuarioEncrypt;
    }

    /**
     * Set clave
     *
     * @param string $clave
     */
    public function setClave($clave)
    {
        $this->clave = hash("sha512",$clave);
    }

    /**
     * Get clave
     *
     * @return string 
     */
    public function getClave()
    {
        return $this->clave;
    }

    /**
     * Set esActivo
     *
     * @param string $esActivo
     */
    public function setEsActivo($esActivo)
    {
        $this->esActivo = $esActivo;
    }

    /**
     * Get esActivo
     *
     * @return string 
     */
    public function getEsActivo()
    {
        return $this->esActivo;
    }

    /**
     * Set fechaRegistro
     *
     * @param date $fechaRegistro
     */
    public function setFechaRegistro($fechaRegistro)
    {
        $this->fechaRegistro = $fechaRegistro;
    }

    /**
     * Get fechaRegistro
     *
     * @return date 
     */
    public function getFechaRegistro()
    {
        return $this->fechaRegistro;
    }

    /**
     * Set fechaUltimoIngreso
     *
     * @param dateTime $fechaUltimoIngreso
     */
    public function setFechaUltimoIngreso($fechaUltimoIngreso)
    {
        $this->fechaUltimoIngreso = $fechaUltimoIngreso;
    }

    /**
     * Get fechaUltimoIngreso
     *
     * @return dateTime 
     */
    public function getFechaUltimoIngreso()
    {
        return $this->fechaUltimoIngreso;
    }

    /**
     * Set perfil
     *
     * @param Expidian\GlobalBundle\Entity\Perfiles $perfil
     */
    public function setPerfil(Perfiles $perfil)
    {
        $this->perfil = $perfil;
    }

    /**
     * Get perfil
     *
     * @return Expidian\GlobalBundle\Entity\Perfiles 
     */
    public function getPerfil()
    {
        return $this->perfil;
    }

    /**
     * Set persona
     *
     * @param Expidian\GlobalBundle\Entity\Personas $persona
     */
    public function setPersona(Personas $persona)
    {
        $this->persona = $persona;
    }

    /**
     * Get persona
     *
     * @return Expidian\GlobalBundle\Entity\Personas 
     */
    public function getPersona()
    {
        return $this->persona;
    }

    public function __toString()
    {
        return $this->getUsuario();
    }

    public function equals(UserInterface $usuario) {
        return ($this===$usuario);
    }

    public function eraseCredentials() {
        
    }

    public function getPassword() {
        return $this->getClave();
    }

    public function getRoles() {
        return $this->getIdPerfil()->getDescripcionPerfil();
    }

    public function getSalt() {
        return $this->getClave();
    }

    public function getUsername() {
        return $this->getUsuarioEncrypt();
    }

}