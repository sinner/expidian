<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Etapas
 *
 * @ORM\Table(name="etapas")
 * @ORM\Entity(repositoryClass="Expidian\GlobalBundle\Entity\Repository\EtapasRepository")
 */
class Etapas
{
    /**
     * @var integer $idEtapa
     *
     * @ORM\Column(name="id_etapa", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="etapas_id_etapa_seq", allocationSize="1", initialValue="1")
     */
    private $idEtapa;

    /**
     * @var string $etapaAbrev
     *
     * @ORM\Column(name="etapa_abrev", type="string", length=5, nullable=false)
     */
    private $etapaAbrev;

    /**
     * @var string $etapa
     *
     * @ORM\Column(name="etapa", type="string", length=60, nullable=false)
     */
    private $etapa;

    /**
     * @var integer $nroConsecutivoEtapa
     *
     * @ORM\Column(name="nro_consecutivo_etapa", type="integer", nullable=false)
     */
    private $nroConsecutivoEtapa;

    /**
     * @var string $isFinal
     *
     * @ORM\Column(name="is_final", type="string", length=2, nullable=false)
     */
    private $isFinal;

    /**
     * @var Procesos
     *
     * @ORM\ManyToOne(targetEntity="Procesos")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_proceso", referencedColumnName="id_proceso")
     * })
     */
    private $proceso;

    /**
     * Set idEtapa
     *
     * @param type $idEtapa 
     */
    public function setIdEtapa($idEtapa) {
        $this->idEtapa = $idEtapa;
    }

        /**
     * Get idEtapa
     *
     * @return integer 
     */
    public function getIdEtapa()
    {
        return $this->idEtapa;
    }

    /**
     * Set etapaAbrev
     *
     * @param string $etapaAbrev
     */
    public function setEtapaAbrev($etapaAbrev)
    {
        $this->etapaAbrev = $etapaAbrev;
    }

    /**
     * Get etapaAbrev
     *
     * @return string 
     */
    public function getEtapaAbrev()
    {
        return $this->etapaAbrev;
    }

    /**
     * Set etapa
     *
     * @param string $etapa
     */
    public function setEtapa($etapa)
    {
        $this->etapa = $etapa;
    }

    /**
     * Get etapa
     *
     * @return string 
     */
    public function getEtapa()
    {
        return $this->etapa;
    }

    /**
     * Set nroConsecutivoEtapa
     *
     * @param integer $nroConsecutivoEtapa
     */
    public function setNroConsecutivoEtapa($nroConsecutivoEtapa)
    {
        $this->nroConsecutivoEtapa = $nroConsecutivoEtapa;
    }

    /**
     * Get nroConsecutivoEtapa
     *
     * @return integer 
     */
    public function getNroConsecutivoEtapa()
    {
        return $this->nroConsecutivoEtapa;
    }

    /**
     * Set isFinal
     *
     * @param string $isFinal
     */
    public function setIsFinal($isFinal)
    {
        $this->isFinal = $isFinal;
    }

    /**
     * Get isFinal
     *
     * @return string 
     */
    public function getIsFinal()
    {
        return $this->isFinal;
    }

    /**
     * Set proceso
     *
     * @param Expidian\GlobalBundle\Entity\Procesos $proceso
     */
    public function setProceso(\Expidian\GlobalBundle\Entity\Procesos $proceso)
    {
        $this->proceso = $proceso;
    }

    /**
     * Get proceso
     *
     * @return Expidian\GlobalBundle\Entity\Procesos 
     */
    public function getProceso()
    {
        return $this->proceso;
    }
    
    public function __toString(){
        return $this->getEtapa();
    }
}