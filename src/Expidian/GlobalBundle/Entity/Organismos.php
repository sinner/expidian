<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Organismos
 *
 * @ORM\Table(name="organismos")
 * @ORM\Entity
 */
class Organismos
{
    /**
     * @var integer $idOrganismo
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
     * @ORM\Column(name="rif", type="string", length=12, nullable=false)
     */
    private $rif;

    /**
     * @var string $nombreOrganismo
     *
     * @ORM\Column(name="nombre_organismo", type="string", length=60, nullable=false)
     */
    private $nombreOrganismo;

    /**
     * @var string $sector
     *
     * @ORM\Column(name="sector", type="string", length=20, nullable=false)
     */
    private $sector;



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
}