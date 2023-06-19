/**
 *
 */
 function header(){
    $.ajax({
        url: "CommonServlet.java",
        cache: false,
        success: function(jsp){
            document.write(jsp);
        }
    });
}