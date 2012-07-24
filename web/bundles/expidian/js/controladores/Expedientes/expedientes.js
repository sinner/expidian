function listar_expedientes(url){
    sinner_grid("form_list_expedientes", url, "div_lista_expedientes");    
}

function reloadGrid_expedientes(url){
    $("#searchFieldf").val("");
    $("#searchStringf").val("");
    $("#criteria_box").val("");
    $("#search_box").val("");
    sinner_grid("form_list_expedientes", url, "div_lista_expedientes");
}

function ordenar_resultados(url){
    sinner_grid("form_list_expedientes", url, "div_lista_expedientes");
}

function change_page(url){
    var url = url;
    sinner_grid("form_list_expedientes", url, "div_lista_expedientes");
}

function busqueda_expedientes(url){
    var criterio = $("#criteria_box").val();
    var parametro = $("#search_box").val();
    $("#searchFieldf").val(criterio);
    $("#searchStringf").val(parametro);
    $("#is_search").val("true");
    sinner_grid("form_list_expedientes", url, "div_lista_expedientes");
}

function busqueda_rapida_expedientes(url,id,campo) {
    var searchFields = campo;
    var searchString = id;
    $("#is_search").val("true");
    $("#searchOperf").val("eq");
    $("#searchFieldf").val(searchFields);
    $("#searchStringf").val(id);
    $("#sidxf").val(searchFields);
    sinner_grid("form_list_expedientes", url, "div_lista_expedientes");
}