<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="/import/header.jsp"%>
        <title>Add Main Category</title>
    </head>
    <body ng-app="popcon" ng-controller="indexCtr" class="container">

        <section>
            <div class="form-group">
                <label>Enter Main Category Name Ex: Man</label>
                <input type="text" ng-model="form.name" class="form-control" placeholder="">
            </div>
            <button type="submit" class="btn btn-primary" ng-click="post();">Add Category</button>
        </section>
        {{form}}
        <script>

                    angular.module("popcon", [])
                            .controller("indexCtr", ["$scope", "$http", function ($scope, $http) {
                                    $scope.form = {};
                                    $scope.post = function () {
                                        $http({
                                            method: 'POST',
                                            url: 'add_Main_Category_API.jsp',
                                            params: $scope.form
                                        }).then(function successCallback(response) {
                                            // this callback will be called 
                                            console.log(response);
                                            // when the response is available
                                        }, function errorCallback(response) {
                                            // called asynchronously if an error occurs
                                            console.log(response);
                                            // or server returns response with an error status.
                                        });
                                    }

                                }]);

        </script>


    </body>
</html>
