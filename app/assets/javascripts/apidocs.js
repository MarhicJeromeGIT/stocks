
$(document).ready( function(){
    var swaggerUi = new SwaggerUi({
       url: '/apidocs.json',
       dom_id: 'swagger-ui-container'
    });
    swaggerUi.load();
    console.log("ok");
});


