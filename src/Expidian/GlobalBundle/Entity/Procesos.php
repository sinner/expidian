<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Procesos
 *
 * @ORM\Table(name="procesos")
 * @ORM\Entity(repositoryClass="Expidian\GlobalBundle\Entity\Repository\ProcesosRepository")
 */
class Procesos
{
    /**
     * @var integer $idProceso
     *
     * @ORM\Column(name="id_proceso", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="procesos_id_proceso_seq", allocationSize="1", initialValue="1")
     */
    private $idProceso;

    /**
     * @var string $procesoAbrev
     *
     * @ORM\Column(name="proceso_abrev", type="string", length=5, nullable=true)
     */
    private $procesoAbrev;

    /**
     * @var string $proceso
     *
     * @ORM\Column(name="proceso", type="string", length=60, nullable=true)
     */
    private $proceso;

    /**
     * @var integer $nroConsecutivoProceso
     *
     * @ORM\Column(name="nro_consecutivo_proceso", type="integer", nullable=false)
     */
    private $nroConsecutivoProceso;



    /**
     * Get idProceso
     *
     * @return integer 
     */
    public function getIdProceso()
    {
        return $this->idProceso;
    }

    /**
     * Set procesoAbrev
     *
     * @param string $procesoAbrev
     */
    public function setProcesoAbrev($procesoAbrev)
    {
        $this->procesoAbrev = $procesoAbrev;
    }

    /**
     * Get procesoAbrev
     *
     * @return string 
     */
    public function getProcesoAbrev()
    {
        return $this->procesoAbrev;
    }

    /**
     * Set proceso
     *
     * @param string $proceso
     */
    public function setProceso($proceso)
    {
        $this->proceso = $proceso;
    }

    /**
     * Get proceso
     *
     * @return string 
     */
    public function getProceso()
    {
        return $this->proceso;
    }

    /**
     * Set nroConsecutivoProceso
     *
     * @param integer $nroConsecutivoProceso
     */
    public function setNroConsecutivoProceso($nroConsecutivoProceso)
    {
        $this->nroConsecutivoProceso = $nroConsecutivoProceso;
    }

    /**
     * Get nroConsecutivoProceso
     *
     * @return integer 
     */
    public function getNroConsecutivoProceso()
    {
        return $this->nroConsecutivoProceso;
    }
    
    
    public function __toString(){
        return $this->proceso;
    }
    
}