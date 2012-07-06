function detect_enter(jquery_element)
{
	var  testTextBox = $('#TestTextBox');
    var code =null;
    jquery_element.keypress(function(e)
    {
        code= (e.keyCode ? e.keyCode : e.which);
        if (code == 13)
        	return true;
        else
        	return false;
    });
}
