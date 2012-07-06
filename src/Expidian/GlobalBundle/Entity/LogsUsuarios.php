<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\LogsUsuarios
 *
 * @ORM\Table(name="logs_usuarios")
 * @ORM\Entity(repositoryClass="Expidian\GlobalBundle\Entity\Repository\LogsUsuariosRepository")
 */
class LogsUsuarios
{
    /**
     * @var integer $idLogUsuario
     *
     * @ORM\Column(name="id_log_usuario", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="logs_usuarios_id_log_usuario_seq", allocationSize="1", initialValue="1")
     */
    private $idLogUsuario;

    /**
     * @var string $logUsuario
     *
     * @ORM\Column(name="log_usuario", type="string", length=300, nullable=false)
     */
    private $logUsuario;

    /**
     * @var string $estatusFinal
     *
     * @ORM\Column(name="estatus_final", type="string", length=20, nullable=true)
     */
    private $estatusFinal;

    /**
     * @var datetime $fechaLog
     *
     * @ORM\Column(name="fecha_log", type="datetime", nullable=false)
     */
    private $fechaLog;

    /**
     * @var Usuarios
     *
     * @ORM\ManyToOne(targetEntity="Usuarios")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_usuario", referencedColumnName="id_usuario")
     * })
     */
    private $usuario;



    /**
     * Get idLogUsuario
     *
     * @return integer 
     */
    public function getIdLogUsuario()
    {
        return $this->idLogUsuario;
    }

    /**
     * Set logUsuario
     *
     * @param string $logUsuario
     */
    public function setLogUsuario($logUsuario)
    {
        $this->logUsuario = $logUsuario;
    }

    /**
     * Get logUsuario
     *
     * @return string 
     */
    public function getLogUsuario()
    {
        return $this->logUsuario;
    }

    /**
     * Set estatusFinal
     *
     * @param string $estatusFinal
     */
    public function setEstatusFinal($estatusFinal)
    {
        $this->estatusFinal = $estatusFinal;
    }

    /**
     * Get estatusFinal
     *
     * @return string 
     */
    public function getEstatusFinal()
    {
        return $this->estatusFinal;
    }

    /**
     * Set fechaLog
     *
     * @param datetime $fechaLog
     */
    public function setFechaLog($fechaLog)
    {
        $this->fechaLog = $fechaLog;
    }

    /**
     * Get fechaLog
     *
     * @return datetime 
     */
    public function getFechaLog()
    {
        return $this->fechaLog;
    }

    /**
     * Set usuario
     *
     * @param Expidian\GlobalBundle\Entity\Usuarios $usuario
     */
    public function setUsuario(\Expidian\GlobalBundle\Entity\Usuarios $usuario)
    {
        $this->usuario = $usuario;
    }

    /**
     * Get idUsuario
     *
     * @return Expidian\GlobalBundle\Entity\Usuarios 
     */
    public function getUsuario()
    {
        return $this->usuario;
    }
}