
$(document).ready( function(){
    console.log("test");
    var swaggerUi = new SwaggerUi({
       url: '/apidocs.json',
       dom_id: 'swagger-ui-container'
    });
    swaggerUi.load();
    console.log("ok");
});


