function listar_usuarios(url){
    sinner_grid("form_list_usuarios", url, "div_lista_usuarios");
}

function reloadGrid_usuarios(url){
    sinner_grid("form_list_usuarios", url, "div_lista_usuarios");
}

function change_page_list_users(url){
    var url = url;
    sinner_grid("form_list_usuarios", url, "div_lista_usuarios");
}

function busqueda_usuarios(url){
    var criterio = $("#criteria_box").val();
    var parametro = $("#search_box").val();
    $("#searchFieldf").val(criterio);
    $("#searchStringf").val(parametro);
    $("#is_search").val("true");
    reloadGrid_usuarios(url);
}

function busqueda_rapida_usuarios(url,id,campo) {
    var searchFields = campo;
    var searchString = id;
    $("#is_search").val("true");
    $("#searchOperf").val("eq");
    $("#searchFieldf").val(searchFields);
    $("#searchStringf").val(id);
    $("#sidxf").val(searchFields);
    reloadGrid_usuarios(url);
}