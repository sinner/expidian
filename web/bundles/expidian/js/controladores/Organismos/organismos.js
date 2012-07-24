function listar_organismos(url){
    sinner_grid("form_list_organismos", url, "div_lista_organismos");    
}

function reloadGrid_organismos(url){
    $("#searchFieldf").val("");
    $("#searchStringf").val("");
    $("#criteria_box").val("");
    $("#search_box").val("");
    sinner_grid("form_list_organismos", url, "div_lista_organismos");
}

function ordenar_resultados(url){
    sinner_grid("form_list_organismos", url, "div_lista_organismos");
}

function change_page(url){
    var url = url;
    sinner_grid("form_list_organismos", url, "div_lista_organismos");
}

function busqueda_organismos(url){
    var criterio = $("#criteria_box").val();
    var parametro = $("#search_box").val();
    $("#searchFieldf").val(criterio);
    $("#searchStringf").val(parametro);
    $("#is_search").val("true");
    sinner_grid("form_list_organismos", url, "div_lista_organismos");
}

function busqueda_rapida_organismos(url,id,campo) {
    var searchFields = campo;
    var searchString = id;
    $("#is_search").val("true");
    $("#searchOperf").val("eq");
    $("#searchFieldf").val(searchFields);
    $("#searchStringf").val(id);
    $("#sidxf").val(searchFields);
    sinner_grid("form_list_organismos", url, "div_lista_organismos");
}