<?php

namespace Expidian\UsuariosBundle\Controller\Session;

use Expidian\UsuariosBundle\Entity\GorUsuarios;
use Symfony\Component\HttpFoundation\Session;

class SessionManager{

    public $web_site = 'expidian';
    public $session_name = 'exp';
    public $login;
    public $session_id;
    public $usuario_session_obj;
    public $session_is_open = false;
    public $session;
    
    const KEY_ENCRYPT = '548c286a61462d896573567b7a30335d4959427e5c7a675e325b6c7a7c';
        
    function __construct(Session $session) {
        $this->session = $session;
        $this->startSession();  
    }
    
    public function startSession(){
        @session_name($this->name);
        $this->session->start();
        $this->session->set("sitioweb", $this->web_site);
    }
    
    public function openSession($usuario_obj){
        
        $this->startSession();
        
        if(array_key_exists('KEY_ENCRYPT', $_SERVER)){
            $_KEY_ENCRYPT = $_SERVER['KEY_ENCRYPT'];
        }else{
            $_KEY_ENCRYPT = self::KEY_ENCRYPT;
        }
                
        $encrypter = new \Phpseclib_TripleDES();
        $encrypter->setKey($_KEY_ENCRYPT);
	
        $this->session->set("usuario",$encrypter->encrypt(serialize($usuario_obj)));
	$this->session->set("login",$encrypter->encrypt(true));
        
        //echo $_KEY_ENCRYPT;
        //echo $_SESSION['usuario'];
        //echo $_SESSION['login'];
         
        $this->session_is_open = true;
        
        return $this->session_is_open;
        
    }
    
    public function readSession(){
        
        $this->startSession();
        
        if($this->session->has('usuario') && $this->session->has('login')){
            
            if(array_key_exists('KEY_ENCRYPT', $_SERVER)){
                $_KEY_ENCRYPT = $_SERVER['KEY_ENCRYPT'];
            }else{
                $_KEY_ENCRYPT = self::KEY_ENCRYPT;
            }
            
            $encrypter = new \Phpseclib_TripleDES();
            $encrypter->setKey($_KEY_ENCRYPT);
            
            $this->login = $encrypter->decrypt($this->session->get('login'));
            //echo $this->login;
            
            $this->usuario_session_obj = unserialize($encrypter->decrypt($this->session->get('usuario')));
                       
            //echo $_KEY_ENCRYPT;
                        
            $this->session_is_open = true;
            
            //var_dump($this->getUsuario());
            
        }
        
        return $this->session_is_open;
        
    }
        
    public function endSession(){
        
        $this->startSession();
        $this->session->clear();
        session_unset(); 
	session_destroy();
        
        $this->session_is_open = false;
        
        unset($GLOBALS['_POST']);
	unset($GLOBALS['_GET']);
	unset($GLOBALS['_REQUEST']);
        
        return $this->session_is_open;
    }
    
        
    
    public function getSessionId(){
        $this->session_id = session_id();
        return $this->session_id;
    }
    
    public function getWeb_site() {
        return $this->web_site;
    }

    public function setWeb_site($web_site) {
        $this->web_site = $web_site;
    }

    public function getSession_name() {
        return $this->session_name;
    }

    public function setSession_name($session_name) {
        $this->session_name = $session_name;
    }

    public function getLogin() {
        return $this->login;
    }

    public function setLogin($login) {
        $this->login = $login;
    }

    public function getSession_id() {
        return $this->session_id;
    }

    public function setSession_id($session_id) {
        $this->session_id = $session_id;
    }

    public function getUsuario_session_obj() {
        return $this->usuario_session_obj;
    }
    
    /**
     * @return \Expidian\GlobalBundle\Entity\Usuarios 
     */
    public function getUsuario() {
        return $this->usuario_session_obj;
    }
    
     /**
     * @return \Expidian\GlobalBundle\Entity\Usuarios 
     */
    public function setUsuario_session_obj($usuario_session_obj) {
        $this->usuario_session_obj = $usuario_session_obj;
    }

    public function getSession_is_open() {
        return $this->session_is_open;
    }

    public function setSession_is_open($session_is_open) {
        $this->session_is_open = $session_is_open;
    }

    public function getSession() {
        return $this->session;
    }

    public function setSession($session) {
        $this->session = $session;
    }



}
?>
