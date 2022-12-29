let pic = false
var alerts = []
let selected
$(function(){
    window.addEventListener("message", function(event){
        if (event.data.callnum) {
            if (event.data.callnum == 0) {
                $("#text").html("No hay llamadas Disponibles");
            }
            else if (event.data.content) {
                $("#text").html(event.data.content + "");
                alerts.push(event.data.content);
            }
            $("#callnum").html(event.data.callnum + "/");
        }
        if (event.data.totalcalls) {
            $("#num").html(event.data.totalcalls + "");
        }
        if (event.data.show == true) {
            var selector = document.getElementById("all")
            selector.style = "display:block;"
        }
        if (event.data.show == false) {
            var selector = document.getElementById("all")
            selector.style = "display:none;"
        }
        if (event.data.left) {
            
            var $av = $(".left");
            $av.addClass('anim');
            setTimeout(function() {
                var $av = $(".left");
                $av.removeClass('anim');
            },1000);
        }
        if (event.data.pic) {
            if ($('#vehicle').length != 0) {
                const vehicle = document.getElementById("vehicle")
                vehicle.remove();
            } 
            pic = true
            let model = event.data.model;
            const element = document.getElementById("text")
            
            const htmlString = `<img class="vehicle" id="vehicle" src="https://bandidosrp.es/ac/vehiclespic/${model}.webp" alt="${model}"></img>`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
            var $frame = $(".t-frame");
            var $border = $(".t-frame-inf-border");
            var $l = $(".left");
            var $lborder = $(".left-border")
            $l.addClass('space');
            $lborder.addClass('space');
            var $r = $(".right");
            var $rborder = $(".right-border")
            $r.addClass('space');
            $rborder.addClass('space');
            var $av = $(".avpag");
            var $avborder = $(".avpag-border")
            $av.addClass('space');
            $avborder.addClass('space');
            $frame.addClass('space')
            $border.addClass('space')
            $frame.removeClass('space')
            $border.removeClass('space')
            $frame.addClass('space')
            $border.addClass('space')
        }
        else {
            
            if (!event.data.avkey) {
                pic = false
                var $frame = $(".t-frame");
                var $border = $(".t-frame-inf-border");
                var $l = $(".left");
                var $lborder = $(".left-border")
                $l.removeClass('space');
                $lborder.removeClass('space');
                var $r = $(".right");
                var $rborder = $(".right-border")
                $r.removeClass('space');
                $rborder.removeClass('space');
                var $av = $(".avpag");
                var $avborder = $(".avpag-border")
                $av.removeClass('space');
                $avborder.removeClass('space');
                $frame.removeClass('space')
                $border.removeClass('space')
                $frame.removeClass('space')
                $border.removeClass('space')
                $frame.removeClass('space')
                $border.removeClass('space')
                if ($('#vehicle').length != 0) {
                    const vehicle = document.getElementById("vehicle")
                    vehicle.remove();
                }
            }
        } 
       
        if (event.data.right) {
            var $av = $(".right");
            $av.addClass('anim');
            setTimeout(function() {
                $av.removeClass('anim');
            },1000);
        }
        if (event.data.avkey) {
            var $av = $(".avpag");
            $av.addClass('anim');
            setTimeout(function() {
                $av.removeClass('anim');
            },1000);
        }
        if (event.data.newalert) {
            var toInsert = `<tr style="margin-top:500px" id="table-container"><td class="table-container"><th class="table-code">Alerta de robo</th><th class="content-table-text">${event.data.content}</th><th class="table-id">ID:` + `${event.data.id}</th></td></tr>`
            $('#table').append(toInsert);

            var $av = $(".t-frame-sup-border");
            var $text1 = $(".callnum");
            var $text2 = $(".cust-text");
            var $text3 = $(".num");
            var $pic = $(".infsvg");
            $av.addClass('alert');
            $text1.addClass('alert-contrast');
            $text2.addClass('alert-contrast');
            $text3.addClass('alert-contrast');
            $pic.addClass('alert-contrast');
            setTimeout(function() {
                $av.removeClass('alert');
                $text1.removeClass('alert-contrast');
                $text2.removeClass('alert-contrast');
                $text3.removeClass('alert-contrast');
                $pic.removeClass('alert-contrast');
            },2000);
        }
        if (event.data.restart == true) {
            $("#callnum").html(0 + "/");
            $("#num").html(0);
            $("#text").html("<h1 style='font-size: 15px'><i class='fa-solid fa-phone'></i> No hay llamadas <span style='background: #db13135b; padding: 1px; border-radius: 5px;'>disponibles</span>.</h1>");
            $(".alerts-table").html("");
            
        }
        if (event.data.newambualert) {
            var $av = $(".t-frame-sup-border");
            var $text1 = $(".callnum");
            var $text2 = $(".cust-text");
            var $text3 = $(".num");
            var $pic = $(".infsvg");
            $av.addClass('ambualert');
            $text1.addClass('alert-contrast');
            $text2.addClass('alert-contrast');
            $text3.addClass('alert-contrast');
            $pic.addClass('alert-contrast');
            setTimeout(function() {
                $av.removeClass('ambualert');
                $text1.removeClass('alert-contrast');
                $text2.removeClass('alert-contrast');
                $text3.removeClass('alert-contrast');
                $pic.removeClass('alert-contrast');
            },2000);
        }
        if (event.data.newmecaalert) {
            var $av = $(".t-frame-sup-border");
            var $text1 = $(".callnum");
            var $text2 = $(".cust-text");
            var $text3 = $(".num");
            var $pic = $(".infsvg");
            $av.addClass('mecaalert');
            $text1.addClass('alert-contrast');
            $text2.addClass('alert-contrast');
            $text3.addClass('alert-contrast');
            $pic.addClass('alert-contrast');
            setTimeout(function() {
                $av.removeClass('mecaalert');
                $text1.removeClass('alert-contrast');
                $text2.removeClass('alert-contrast');
                $text3.removeClass('alert-contrast');
                $pic.removeClass('alert-contrast');
            },2000);
        }
        if (event.data.newtaxialert) {
            var $av = $(".t-frame-sup-border");
            var $text1 = $(".callnum");
            var $text2 = $(".cust-text");
            var $text3 = $(".num");
            var $pic = $(".infsvg");
            $av.addClass('taxialert');
            $text1.addClass('alert-contrast');
            $text2.addClass('alert-contrast');
            $text3.addClass('alert-contrast');
            $pic.addClass('alert-contrast');
            setTimeout(function() {
                $av.removeClass('taxialert');
                $text1.removeClass('alert-contrast');
                $text2.removeClass('alert-contrast');
                $text3.removeClass('alert-contrast');
                $pic.removeClass('alert-contrast');
            },2000);
        }
        var $sup = $(".t-frame-sup-border");
        var $inf = $(".t-frame-inf-border");
        if (event.data.inConfig == true) {
            var configmenu = document.getElementById("configmenu")
            configmenu.style = "display:block"
            $sup.addClass('InConfig')
            $inf.addClass('InConfig')
            const element = document.getElementById("t-frame")
            const htmlString = `<h1 class="cust-text" id="cust-text">Presiona <span style='background: gray; border-radius: 4px; padding: 2px 5px 2px 5px;'>[i]</span> Para Cerrar/Abrir la cfg</h1>`
            const insertAfter = (element, htmlString) => element.insertAdjacentHTML("afterend", htmlString)
            insertAfter(element, htmlString)
        }

        if (event.data.closeConfigMenu == true) {
            var selector = document.getElementById("configmenu")
            selector.style = "display:none"
        }


    })
})

$(function(){
    $("#all").draggable();
    $("#configmenu").draggable();
    $("#table").on('click', 'tr', function () {
        var container = document.getElementsByClassName('.menu')[0];
        selected = $(this).index();
        const ele = document.getElementById('menu');
        const menu = document.getElementById('menu');
        menu.style = "display:block;"
        document.addEventListener('click', contextmenu);
        function contextmenu(e) {
            if (e.target.id == "table-container" || $(e.target).parents("#table-container").length) {
                if (e.target.id == "menu" || $(e.target).parents("#menu").length) { // Quick edit
                    
                }
                else {
                    e.preventDefault();
                
                    const rect = ele.getBoundingClientRect();
                    const x = e.clientX;
                    const y = e.clientY;

                    menu.style.top = `${y}px`;
                    menu.style.left = `${x}px`;
            
                    $(".menu-style").css("left", x + "px");
                    $(".menu-style").css("top", y + "px");
    
                }
            } 
            else {
                menu.style = "display:none;"
            }

        };
    });
});

document.addEventListener("DOMContentLoaded", () => {
    $("#text").html("<h1 style='font-size: 15px'><i class='fa-solid fa-phone'></i> No hay llamadas <span style='background: #db13135b; padding: 1px; border-radius: 5px;'>disponibles</span>.</h1>");
    var selector = document.getElementById("all")
    selector.style = "display:none;"
    var contextmenu = document.getElementById("menu")
    contextmenu.style = "display:none;"
    var configmenu = document.getElementById("configmenu")
    configmenu.style = "display:none"
});

document.addEventListener('keypress', logKey);


function logKey(e) {
    if (e.keyCode == 105) {
        var $sup = $(".t-frame-sup-border");
        var $inf = $(".t-frame-inf-border");
        const cust = document.getElementById("cust-text")
        cust.remove();
        $sup.removeClass('InConfig')
        $inf.removeClass('InConfig')
        var configmenu = document.getElementById("configmenu")
        configmenu.style = "display:none"
        var contextmenu = document.getElementById("menu")
        contextmenu.style = "display:none"
        $.post(`http:/${GetParentResourceName()}/exit`, JSON.stringify({}));
    }
}



let wtfdude = false

setInterval(function() {
    if ($('#text').text().length > 150) {
        var $frame = $(".t-frame");
        var $border = $(".t-frame-inf-border");
        var $l = $(".left");
        var $lborder = $(".left-border")
        $l.addClass('space');
        $lborder.addClass('space');
        var $r = $(".right");
        var $rborder = $(".right-border")
        $r.addClass('space');
        $rborder.addClass('space');
        var $av = $(".avpag");
        var $avborder = $(".avpag-border")
        $av.addClass('space');
        $avborder.addClass('space');
        $frame.addClass('space')
        $border.addClass('space')
        wtfdude = true
    }
    else {
        if (wtfdude == true && pic == false ) {
            
            var $frame = $(".t-frame");
            var $border = $(".t-frame-inf-border");
            $frame.removeClass('space')
            $border.removeClass('space')
            var $l = $(".left");
            $l.removeClass('space');
            var $r = $(".right");
            $r.removeClass('space');
            var $r = $(".avpag");
            $r.removeClass('space');
            var $lborder = $(".left-border")
            $lborder.removeClass('space');
            var $rborder = $(".right-border")
            $rborder.removeClass('space');
            var $avborder = $(".avpag-border")
            $avborder.removeClass('space');
            wtfdude = false
        }
    }
    if (parseInt($('#callnum').text()) > 9) {
        var $pepe = $(".num");
        $pepe.addClass('space');
    }
    else {
        var $pepe = $(".num");
        $pepe.removeClass('space');
    }
}, 0);

// Menu callbacks

$(function() {
    document.getElementById("images-button").addEventListener("click", tooglepics);
    document.getElementById("delete-button").addEventListener("click", deletealerts);
    document.getElementById("minimenu-button").addEventListener("click", deletealert);
    document.getElementById("togglealerts-button").addEventListener("click", togglealerts)
    function tooglepics() {
        $.post(`http:/${GetParentResourceName()}/tooglepic`, JSON.stringify({}));
    }
    function deletealerts() {
        $.post(`http:/${GetParentResourceName()}/deletealerts`, JSON.stringify({}));
    }
    function deletealert() {
        $.post(`http:/${GetParentResourceName()}/deletealert`, JSON.stringify({
            selectedId: $("tr").eq(selected).index()
        }));
        $("tr").eq(selected).remove();
    }
    function togglealerts() {
        $.post(`http:/${GetParentResourceName()}/togglealerts`, JSON.stringify({}));
    }
});
