<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-theme.min.css">

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/angular.min.js"></script>
<script src="js/angular-resource.min.js"></script>

<script>

    var app=angular.module("popcon", ["ngResource"]);
            app.factory("MainCategory", ["$resource", function ($resource) {
                    return $resource("/webresources/main_Category_/:id", {id: '@id'},
                            {
                                'update': {method: 'PUT'}
                            }
                    );
                }]);
              app.factory("firstSubCategory", ["$resource", function ($resource) {
                    return $resource("/webresources/First_Sub_Category_/:id", {id: '@id'},
                            {
                                'update': {method: 'PUT'}
                            }
                    );
                }]);
</script>
