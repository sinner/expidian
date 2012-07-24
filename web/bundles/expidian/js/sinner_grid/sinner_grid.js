/**
 * Indica si se está haciendo o no una búsqueda
 */
var search = new String("false");

/**
 * Indica el número de página en un grupo de registros listados y paginados
 */
var page = new String("1");

/**
 * Indica el número de registros que se mostrarán por páginas
 */
var rows = new String("10");

/**
 * Indica el nombre del campo por el que se desea buscar
 */
var searchField = new String("");

/**
 * Indica la operación de búsqueda
 */
var searchOper = new String("eq");

/**
 * Indica el parámetro de búsqueda
 */
var searchString = new String("");

/**
 * Indica el nombre del campo por el que se ordenará los registros listados
 */
var grid_sort = new String("");

/**
 * Indica el tipo orden que tendran el grupo de registros ASC DESC
 */
var grid_direction = new String("");

function sinner_grid(form_paginate, url_controller, div_string){

        var is_search = $("#"+form_paginate+" input#is_search").val();
        var searchField = $("#"+form_paginate+" input#searchFieldf").val();
        var searchOper = $("#"+form_paginate+" input#searchOperf").val();
        var searchString = $("#"+form_paginate+" input#searchStringf").val();
        var grid_sort = $("#"+form_paginate+" input#grid_sort").val();
        var grid_direction = $("#"+form_paginate+" input#grid_direction").val();
        var rows = $("#"+form_paginate+" input#rows").val();
        
	if(is_search != ""){search = is_search;}
	//if(_page != "" && !isNaN(_page) && _page>0){page = _page;}
	if(rows!=""){rows = rows;}
	if(searchField!=""){searchField = searchField;}
	if(searchOper!=""){searchOper = searchOper;}
	if(grid_sort!=""){grid_sort = grid_sort;}
	if(grid_direction!=""){grid_direction = grid_direction;}else{grid_direction = "ASC";}
	searchString = searchString;
	
	var datos = "&is_search="+search+"&grid_sort="+grid_sort+"&grid_direction="+grid_direction+"&rows="+rows+"&searchField="+searchField+"&searchString="+searchString+"&searchOper="+searchOper;
        
	$.ajax({
            type: "POST",
            dataType: "html",
            data: datos,
            url: url_controller,
            success: function(datos){
                    $("#"+div_string).html(datos).fadeIn("slow");
            }
	});	
	
}