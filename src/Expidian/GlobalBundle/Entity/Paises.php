<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Paises
 *
 * @ORM\Table(name="paises")
 * @ORM\Entity
 */
class Paises
{
    /**
     * @var integer $idPais
     *
     * @ORM\Column(name="id_pais", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="paises_id_pais_seq", allocationSize="1", initialValue="1")
     */
    private $idPais;

    /**
     * @var string $pais
     *
     * @ORM\Column(name="pais", type="string", length=35, nullable=false)
     */
    private $pais;
    
    
    /**
     * Set idPais
     * 
     * @param Integer $idPais 
     */
    public function setIdPais($idPais) {
        $this->idPais = $idPais;
    }

        
    /**
     * Get idPais
     *
     * @return integer 
     */
    public function getIdPais()
    {
        return $this->idPais;
    }

    /**
     * Set pais
     *
     * @param string $pais
     */
    public function setPais($pais)
    {
        $this->pais = $pais;
    }

    /**
     * Get pais
     *
     * @return string 
     */
    public function getPais()
    {
        return $this->pais;
    }
    
    public function __toString(){
        return $this->getPais();
    }
}