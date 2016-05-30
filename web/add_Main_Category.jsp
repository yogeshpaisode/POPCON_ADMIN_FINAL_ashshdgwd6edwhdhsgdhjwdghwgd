<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="/import/header.jsp"%>
        <title>Add Main Category</title>
    </head>
    <body ng-app="popcon" ng-controller="indexCtr" ng-cloak="" ng-init="get();" class="container">

        <section>
            <div class="form-group">
                <label>Enter Main Category Name Ex: Man</label>
                <input type="text" ng-model="mainCategory.name" class="form-control" placeholder="">
            </div>
            <button type="submit" class="btn btn-primary" ng-click="post();">Add Category</button>
        </section>
        <h4>Status: <b>{{result}}</b></h4>
        <br>
        <table class = "table table-bordered">
            <caption>{{getMessage}}</caption>
            <thead>
                <tr>
                    <th>Sr.No</th>
                    <th>Category Name</th>
                    <th>Update Action</th>
                </tr>
            </thead>
            <tbody>
                <tr ng-repeat="l in list">
                    <td>{{($index + 1)}}</td>
                    <td><input type="text" value="{{l.name}}" ng-model="l.name"></td>
                    <td><input type="text" value="{{l.id}}" hidden=""><button ng-click="put(l);">Update</button></td></td>
                </tr>
            </tbody>
        </table>
        <script>

            angular.module("popcon", ["ngResource"])
                    .factory("MainCategory", ["$resource", function ($resource) {
                            return $resource("http://localhost:8084//webresources/main_Category_"
                                    , null,
                                    {
                                        'update': {method: 'PUT'}
                                    }
                            );
                        }])
                    .controller("indexCtr", ["$scope", "$http", "MainCategory", function ($scope, $http, MainCategory) {
                            $scope.list = [];
                            $scope.mainCategory = new MainCategory();
                            $scope.get = function () {
                                $scope.getMessage = "Getting List...";
                                $scope.list = MainCategory.query(function (response) {
                                    $scope.getMessage = "Success : fetching list";
                                }, function (response) {
                                    $scope.getMessage = "Error : fetching list";
                                });
                            } //End of GET
                            $scope.post = function () {
                                $scope.result = "Adding New Entry..";
                                $scope.mainCategory.$save(function (res) {
                                    $scope.result = "Success : Last Entry was added successfully..";
                                    $scope.list.push({id: res.id, name: res.name});
                                }, function () {
                                    $scope.result = "Error : Something Went wrong..";
                                });
                            }// End of POST
                            $scope.put = function (list) {
                                console.log(angular.toJson(list));
                                list.$update(function (res) {
                                    console.log(res);
                                }, function () {
                                    alert("Error ok");
                                });
                            }//End of PUT
                        }]);

        </script>


    </body>
</html>
