<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Perfiles
 *
 * @ORM\Table(name="perfiles")
 * @ORM\Entity
 */
class Perfiles
{
    /**
     * @var integer $idPerfil
     *
     * @ORM\Column(name="id_perfil", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="perfiles_id_perfil_seq", allocationSize="1", initialValue="1")
     */
    private $idPerfil;

    /**
     * @var string $perfil
     *
     * @ORM\Column(name="perfil", type="string", length=50, nullable=false)
     */
    private $perfil;

    /**
     * @var string $descripcionPerfil
     *
     * @ORM\Column(name="descripcion_perfil", type="string", length=200, nullable=false)
     */
    private $descripcionPerfil;



    /**
     * Get idPerfil
     *
     * @return integer 
     */
    public function getIdPerfil()
    {
        return $this->idPerfil;
    }

    /**
     * Set perfil
     *
     * @param string $perfil
     */
    public function setPerfil($perfil)
    {
        $this->perfil = $perfil;
    }
    
    /**
     * Set idPerfil
     * 
     * @param Integer $idPerfil 
     */
    public function setIdPerfil($idPerfil) {
        $this->idPerfil = $idPerfil;
    }

        
    /**
     * Get perfil
     *
     * @return string 
     */
    public function getPerfil()
    {
        return $this->perfil;
    }

    /**
     * Set descripcionPerfil
     *
     * @param string $descripcionPerfil
     */
    public function setDescripcionPerfil($descripcionPerfil)
    {
        $this->descripcionPerfil = $descripcionPerfil;
    }

    /**
     * Get descripcionPerfil
     *
     * @return string 
     */
    public function getDescripcionPerfil()
    {
        return $this->descripcionPerfil;
    }

    public function __toString(){
        return $this->getPerfil();
    }
    
}