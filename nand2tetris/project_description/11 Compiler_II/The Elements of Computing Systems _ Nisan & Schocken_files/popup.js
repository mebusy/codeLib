/*
    --------------------------------------------------------------------------
    Code for link-hover text boxes
    By Nicolas Honing
    Usage: <a onmouseover="popup('popup content', width)">a link</a>
     (width is optional - default is in CSS: #nand_popup {width: x;},
      escape " in content with &quot;)
    Tutorial and support at http://nicolashoening.de?twocents&nr=8
    --------------------------------------------------------------------------
*/

// create the popup box - remember to give it some width in your styling 
document.write('<div id="nand_popup" onmouseover="overPopup(true);" onmouseout="overPopup(false);" style="position:abolute; display:none; z-index:200;"></div>');

var minMargin = 15; // set how much minimal space there should be (in pixels)
                    // between the popup and everything else (borders, mouse)
var ready = false;  // we are ready when the mouse event is set up
var default_width = 200; // will be set to width from css in document.ready
var visible = false;
var mouseoverPopup = false;
var oldmsg = '';
/* Prepare popup and define the mouseover callback */
jQuery(document).ready(function(){
    $('#nand_popup').hide();
    css_width = $('#nand_popup').width();
    if (css_width != 0) default_width = css_width;
    // set dynamic coords when the mouse moves
	$(document).mousemove(function(e){ 
        var x,y;
      
        x = $(document).scrollLeft() + e.clientX;
        y = $(document).scrollTop() + e.clientY;

        x += 10; // important: if the popup is where the mouse is, the hoverOver/hoverOut events flicker
      
        var x_y = nudge(x,y); // avoids edge overflow
      
        // remember: the popup is still hidden
		if (visible==false) {
			$('#nand_popup').css('top', x_y[1] + 'px');
			$('#nand_popup').css('left', x_y[0] + 'px');
		}
    });
    ready = true;
});

/*
 The actual callback:
 Write message, show popup w/ custom width if necessary,
 make sure it disappears on mouseout
*/
function popup(msg, isFile)
{
	if (oldmsg != msg) {
		visible = false;
		$('#nand_popup').hide();
		mouseoverPopup = false;
	}
    if (ready) {
		if (isFile) {
			oldmsg = msg;
			msg = readFile(msg);
		}
        // use default width if not customized here
        //if (typeof width === "undefined"){
        //    width = default_width;
        //}
        // write content and display
		visible = true;	
        $('#nand_popup').html(msg).show();
		document.getElementById('nand_popup').focus() 
        // make sure popup goes away on mouse out
        // the event obj needs to be gotten from the virtual 
        //   caller, since we use onmouseover='popup(msg)' 
        var t = getTarget(arguments.callee.caller.arguments[0]);
        $(t).unbind('mouseout').bind('mouseout', 
            function(e){
				var t = setTimeout("hideAll()",150);
            }
        );
    }
}

function hideAll() {
	if (mouseoverPopup == false) {
		$('#nand_popup').hide();
		visible = false;
	}
}

function overPopup(isOverPopup) {
	mouseoverPopup = isOverPopup;
	if (isOverPopup==false) {
		$('#nand_popup').hide();
		visible = false;
	}
}

function readFile(filename) {
	var oRequest = new XMLHttpRequest();
	var sURL = "http://"
			 + self.location.hostname+'/'
			 + filename;

	oRequest.open("GET",sURL,false);
	oRequest.send(null)

	if (oRequest.status==200) {
		return oRequest.responseText;
	}
	else {
		return "Error fetching file from server.";
	}
}

/* Avoid edge overflow */
function nudge(x,y)
{
    var win = $(window);
    
    // When the mouse is too far on the right, put window to the left
    var xtreme = $(document).scrollLeft() + win.width() - $('#nand_popup').width() - minMargin;
    if(x > xtreme) {
        x -= $('#nand_popup').width() + 2 * minMargin;
    }
    x = max(x, 0);

    // When the mouse is too far down, move window up
    if((y + $('#nand_popup').height()) > (win.height() +  $(document).scrollTop())) {
        y -= $('#nand_popup').height() + minMargin;
    }

    return [ x, y ];
}

/* custom max */
function max(a,b){
    if (a>b) return a;
    else return b;
}

/*
 Get the target (element) of an event.
 Inspired by quirksmode
*/
function getTarget(e) {
    var targ;
    if (!e) var e = window.event;
    if (e.target) targ = e.target;
    else if (e.srcElement) targ = e.srcElement;
    if (targ.nodeType == 3) // defeat Safari bug
        targ = targ.parentNode;
    return targ;
}
