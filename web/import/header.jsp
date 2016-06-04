<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-theme.min.css">

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/angular.min.js"></script>
<script src="js/angular-resource.min.js"></script>

<script>

    var app = angular.module("popcon", ["ngResource"]);
    app.factory("MainCategory", ["$resource", function ($resource) {
            return $resource("/webresources/main_Category_/:mainCategoryId", {mainCategoryId: '@mainCategoryId'},
                    {
                        'update': {method: 'PUT',isArray:true},
                        'delete': {method: 'DELETE',isArray:true}
                    }
            );
        }]);
    app.factory("firstSubCategory", ["$resource", function ($resource) {
            return $resource("/webresources/First_Sub_Category_/:firstSubcategoryId", {firstSubcategoryId: '@firstSubcategoryId'},
                    {
                        'update': {method: 'PUT',isArray:true},
                        'delete': {method: 'DELETE',isArray:true}
                    }
            );
        }]);
</script>
