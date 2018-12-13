$(document).ready(function(){
    base_url = "https://haskell-trab-otvss.c9users.io/";
    
    $('.aula-thumb4').on({
        mouseenter: function(){
            var id = parseInt($(this).attr("id").replace("/aula/", "")) - 1;
        
            $.ajax({
                url: base_url+"dadosAula",
                data: {'aulaid': 1},
                method: 'post',
                assync: false,
                success: function(result){
                    var resp = result.resp[id];
                    
                    $('<div>',{
                        class: 'exibir-inf',
                    }).appendTo('body').html("<h3>"+resp.titulo+"</h3><br><p>"+resp.descricao+"</p>");
                }
            });
        },
        mouseout: function(){
            $('.exibir-inf').remove();
        },
    })
});