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
            <thead>
                <tr>
                    <th>Sr.No</th>
                    <th>Category Name</th>
                    <th>Update Action</th>
                    <th>Delete Action</th>
                </tr>
            </thead>
            <tbody>
                <tr ng-repeat="l in list">
                    <td>{{($index + 1)}}</td>
                    <td><input type="text" value="{{l.name}}" ng-model="l.name"></td>
                    <td><input type="text" value="{{l.id}}" hidden=""><button ng-click="put(l, $index);">Update</button></td></td>
                    <td><button ng-click="delete(l, $index);">Delete</button></td>
                </tr>
            </tbody>
        </table>
        <script>

            angular.module("popcon", ["ngResource"])
                    .factory("MainCategory", ["$resource", function ($resource) {
                            return $resource("http://localhost:8084//webresources/main_Category_/:id", {id: '@id'},
                                    {
                                        'update': {method: 'PUT'}
                                    }
                            );
                        }])
                    .controller("indexCtr", ["$scope", "$http", "MainCategory", function ($scope, $http, MainCategory) {
                            $scope.list = [];
                            $scope.mainCategory = new MainCategory();
                            $scope.get = function () {
                                $scope.result="Processing...";
                                $scope.list = MainCategory.query(function (response) {
                                    $scope.result = "Success : fetching list";
                                }, function (response) {
                                    $scope.result = "Error : fetching list";
                                });
                            } //End of GET
                            $scope.post = function () {
                                $scope.result="Processing...";
                                $scope.mainCategory.$save(function (res) {
                                    $scope.result = "Success : Last Entry was added successfully..";
                                    $scope.mainCategory.id = res.id;
                                    $scope.list.push($scope.mainCategory);
                                    $scope.mainCategory = new MainCategory();
                                }, function () {
                                    $scope.result = "Error : Something Went wrong..";
                                });
                            }// End of POST
                            $scope.put = function (list) {
                                $scope.result="Processing...";
                                list.$update(function (res) {
                                    $scope.result = "Success : Last entry was Updated Successfully..";
                                }, function () {
                                    $scope.result = "Error ; Something went wrong while Updating last entry..";
                                });
                            }//End of PUT
                            $scope.delete = function (list) {
                                $scope.result="Processing...";
                                list.$delete(function () {
                                    $scope.result = "Success : Last Entry was deleted successfully..";
                                    $scope.get();
                                }, function () {
                                    $scope.result = "Error ; Something Went wrong while deleting last entry..";
                                });
                            }//End of Delete
                        }]);

        </script>


    </body>
</html>
