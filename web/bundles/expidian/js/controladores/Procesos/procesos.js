function listar_procesos(url){
    sinner_grid("form_list_procesos", url, "div_lista_procesos");    
}

function reloadGrid_procesos(url){
    $("#searchFieldf").val("");
    $("#searchStringf").val("");
    $("#criteria_box").val("");
    $("#search_box").val("");
    sinner_grid("form_list_procesos", url, "div_lista_procesos");
}

function ordenar_resultados(url){
    sinner_grid("form_list_procesos", url, "div_lista_procesos");
}

function change_page(url){
    var url = url;
    sinner_grid("form_list_procesos", url, "div_lista_procesos");
}

function busqueda_procesos(url){
    var criterio = $("#criteria_box").val();
    var parametro = $("#search_box").val();
    $("#searchFieldf").val(criterio);
    $("#searchStringf").val(parametro);
    $("#is_search").val("true");
    sinner_grid("form_list_procesos", url, "div_lista_procesos");
}

function busqueda_rapida_procesos(url,id,campo) {
    var searchFields = campo;
    var searchString = id;
    $("#is_search").val("true");
    $("#searchOperf").val("eq");
    $("#searchFieldf").val(searchFields);
    $("#searchStringf").val(id);
    $("#sidxf").val(searchFields);
    sinner_grid("form_list_procesos", url, "div_lista_procesos");
}