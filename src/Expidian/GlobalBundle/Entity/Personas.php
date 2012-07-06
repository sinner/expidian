<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Bridge\Doctrine\Validator\Constraints as DoctrineAssert;

/**
 * Expidian\GlobalBundle\Entity\Personas
 *
 * @DoctrineAssert\UniqueEntity(fields="cedulaDeIdentidad", message="Esta persona ya se encuentra registrada en la base de datos.")
 * 
 * @ORM\Table(name="personas")
 * @ORM\Entity
 */
class Personas
{
    /**
     * @var integer $idPersona
     *
     * @ORM\Column(name="id_persona", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="personas_id_persona_seq", allocationSize="1", initialValue="1")
     */
    private $idPersona;

    /**
     * @var string $nombre
     *
     * @Assert\NotBlank(message="El Nombre del usuario es un dato obligatorio.")
     * 
     * @ORM\Column(name="nombre", type="string", length=60, nullable=false)
     */
    private $nombre;

    /**
     * @var string $apellido
     * 
     * @Assert\NotBlank(message="El Apellido del usuario es un dato obligatorio.")
     *
     * @ORM\Column(name="apellido", type="string", length=60, nullable=false)
     */
    private $apellido;

    /**
     * @var string $nacionalidad
     *
     * @Assert\Choice(choices = {"V", "E"}, message = "Debe Seleccionar un Valor Válido de Nacionalidad V o E.")
     * 
     * @ORM\Column(name="nacionalidad", type="string", length=1, nullable=true)
     */
    private $nacionalidad;

    /**
     * @var decimal $cedulaDeIdentidad
     *
     * @Assert\NotBlank(message="El Número de Cédula o Pasaporte es un dato obligatorio.")
     * @Assert\Regex(pattern="/^0*[1-9][0-9]*$/" , message="El valor {{ value }} no es un {{ type }} válido.") 
     * 
     * @ORM\Column(name="cedula_de_identidad", type="decimal", nullable=false, unique=true)
     */
    private $cedulaDeIdentidad;

    /**
     * @var decimal $telefono1
     * 
     * @Assert\Regex(pattern="/^0*[1-9][0-9]*$/" , message="El valor {{ value }} no es un {{ type }} válido.") 
     * @Assert\MaxLength(limit=11,message="Ingrese un Número de Teléfono válido.")
     * @Assert\MinLength(limit=10,message="Ingrese un Número de Teléfono válido.")
     * 
     * @ORM\Column(name="telefono1", type="decimal", nullable=true)
     */
    private $telefono1;

    /**
     * @var decimal $telefono2
     * 
     * @Assert\Regex(pattern="/^0*[1-9][0-9]*$/" , message="El valor {{ value }} no es un {{ type }} válido.") 
     * @Assert\MaxLength(limit=11,message="Ingrese un Número de Teléfono válido.")
     * @Assert\MinLength(limit=10,message="Ingrese un Número de Teléfono válido.")
     * 
     * @ORM\Column(name="telefono2", type="decimal", nullable=true)
     */
    private $telefono2;

    /**
     * @var string $email
     *
     * @Assert\Email(message="E-mail inválido")
     * 
     * @ORM\Column(name="email", type="string", length=255, nullable=true)
     */
    private $email;

    /**
     * @var Paises
     *
     * @ORM\ManyToOne(targetEntity="Paises")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_pais", referencedColumnName="id_pais")
     * })
     */
    private $pais;



    /**
     * Get idPersona
     *
     * @return integer 
     */
    public function getIdPersona()
    {
        return $this->idPersona;
    }

    /**
     * Set nombre
     *
     * @param string $nombre
     */
    public function setNombre($nombre)
    {
        $this->nombre = ucwords($nombre);
    }

    /**
     * Get nombre
     *
     * @return string 
     */
    public function getNombre()
    {
        return $this->nombre;
    }

    /**
     * Set apellido
     *
     * @param string $apellido
     */
    public function setApellido($apellido)
    {
        $this->apellido = ucwords($apellido);
    }

    /**
     * Get apellido
     *
     * @return string 
     */
    public function getApellido()
    {
        return $this->apellido;
    }

    /**
     * Set nacionalidad
     *
     * @param string $nacionalidad
     */
    public function setNacionalidad($nacionalidad)
    {
        $this->nacionalidad = strtoupper($nacionalidad);
    }

    /**
     * Get nacionalidad
     *
     * @return string 
     */
    public function getNacionalidad()
    {
        return $this->nacionalidad;
    }

    /**
     * Set cedulaDeIdentidad
     *
     * @param decimal $cedulaDeIdentidad
     */
    public function setCedulaDeIdentidad($cedulaDeIdentidad)
    {
        $this->cedulaDeIdentidad = $cedulaDeIdentidad;
    }

    /**
     * Get cedulaDeIdentidad
     *
     * @return decimal 
     */
    public function getCedulaDeIdentidad()
    {
        return $this->cedulaDeIdentidad;
    }

    /**
     * Set telefono1
     *
     * @param decimal $telefono1
     */
    public function setTelefono1($telefono1)
    {
        $this->telefono1 = $telefono1;
    }

    /**
     * Get telefono1
     *
     * @return decimal 
     */
    public function getTelefono1()
    {
        return $this->telefono1;
    }

    /**
     * Set telefono2
     *
     * @param decimal $telefono2
     */
    public function setTelefono2($telefono2)
    {
        $this->telefono2 = $telefono2;
    }

    /**
     * Get telefono2
     *
     * @return decimal 
     */
    public function getTelefono2()
    {
        return $this->telefono2;
    }

    /**
     * Set email
     *
     * @param string $email
     */
    public function setEmail($email)
    {
        $this->email = strtolower($email);
    }

    /**
     * Get email
     *
     * @return string 
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * Set pais
     *
     * @param Expidian\GlobalBundle\Entity\Paises $pais
     */
    public function setPais(\Expidian\GlobalBundle\Entity\Paises $pais)
    {
        $this->pais = $pais;
    }

    /**
     * Get pais
     *
     * @return Expidian\GlobalBundle\Entity\Paises 
     */
    public function getPais()
    {
        return $this->pais;
    }

    public function __toString(){
        return ucwords($this->nombre." ".$this->apellido);
    }
    
}