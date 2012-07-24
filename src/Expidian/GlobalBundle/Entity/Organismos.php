<?php

namespace Expidian\GlobalBundle\Entity;

use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Bridge\Doctrine\Validator\Constraints as DoctrineAssert;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Organismos
 *
 * @ORM\Table(name="organismos")
 * @ORM\Entity(repositoryClass="Expidian\GlobalBundle\Entity\Repository\OrganismosRepository")
 */
class Organismos
{
    /**
     * @var integer $idOrganismo
     *
     * @Assert\Regex(pattern="/^0*[1-9][0-9]*$/" , message="El valor {{ value }} no es un {{ type }} válido.") 
     * 
     * @ORM\Column(name="id_organismo", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="organismos_id_organismo_seq", allocationSize="1", initialValue="1")
     */
    private $idOrganismo;

    /**
     * @var string $rif
     * 
     * @Assert\NotBlank(message="Debe Ingresar el RIF del Organismo. No se han obtenido algunos datos indispensables para seguir con la operaci&oacute;n.")
     * 
     * @ORM\Column(name="rif", type="string", length=12, nullable=false)
     */
    private $rif;

    /**
     * @var string $nombreOrganismo
     * 
     * @Assert\NotBlank(message="Debe Ingresar el Nombre del Organismo. No se han obtenido algunos datos indispensables para seguir con la operaci&oacute;n.")
     *
     * @ORM\Column(name="nombre_organismo", type="string", length=60, nullable=false)
     */
    private $nombreOrganismo;

    /**
     * @var string $sector
     * 
     * @Assert\NotBlank(message="Debe Ingresar el Sector del Organismo. No se han obtenido algunos datos indispensables para seguir con la operaci&oacute;n.")
     *
     * @ORM\Column(name="sector", type="string", length=20, nullable=false)
     */
    private $sector;

    
    /**
     * Set idOrganismo
     * 
     * @param type $idOrganismo 
     */
    public function setIdOrganismo($idOrganismo) {
        $this->idOrganismo = $idOrganismo;
    }

    
    /**
     * Get idOrganismo
     *
     * @return integer 
     */
    public function getIdOrganismo()
    {
        return $this->idOrganismo;
    }

    /**
     * Set rif
     *
     * @param string $rif
     */
    public function setRif($rif)
    {
        $this->rif = $rif;
    }

    /**
     * Get rif
     *
     * @return string 
     */
    public function getRif()
    {
        return $this->rif;
    }

    /**
     * Set nombreOrganismo
     *
     * @param string $nombreOrganismo
     */
    public function setNombreOrganismo($nombreOrganismo)
    {
        $this->nombreOrganismo = $nombreOrganismo;
    }

    /**
     * Get nombreOrganismo
     *
     * @return string 
     */
    public function getNombreOrganismo()
    {
        return $this->nombreOrganismo;
    }

    /**
     * Set sector
     *
     * @param string $sector
     */
    public function setSector($sector)
    {
        $this->sector = $sector;
    }

    /**
     * Get sector
     *
     * @return string 
     */
    public function getSector()
    {
        return $this->sector;
    }
    
    public function __toString()
    {
        return $this->getNombreOrganismo();
    }
    
}