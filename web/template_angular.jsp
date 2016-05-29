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
                <label>Email address</label>
                <input type="text" class="form-control" placeholder="">
            </div>
            <button type="submit" class="btn btn-default">Submit</button>
        </section>
        
        <script>

                    angular.module("popcon", [])
                            .controller("indexCtr", ["$scope", "$http", function ($scope, $http) {

                                }]);

        </script>


    </body>
</html>
