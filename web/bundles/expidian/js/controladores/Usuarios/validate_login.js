/**
 * @description Valida que el Usuario haya ingresado su Usuario y su Clave en el Formulario de Acceso al Sistema
 * @return boolean
 */
function validate_login(){
    var usuario = $("#username").val();
    var clave = $("#password").val();
    var resp = true;
    if(usuario == "" || clave==""){
        jAlert("Debe Ingresar su Usuario y Clave para poder acceder al Sistema","Datos Faltantes Para La Autenticaci&oacute;n");
        resp = false;
    }
    return resp;
}