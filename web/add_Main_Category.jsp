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
                <input type="text" ng-model="form.name" class="form-control" placeholder="">
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
                    <td><input type="text" value="{{l.name}}"></td>
                    <td><input type="text" value="{{l.id}}" hidden=""><button ng-click="put($index);">Update</button></td></td>
                </tr>
            </tbody>
        </table>
        <script>

            angular.module("popcon", [])
                    .controller("indexCtr", ["$scope", "$http", function ($scope, $http) {
                            var URL = "add_Main_Category_API.jsp";
                            $scope.list = [];
                            $scope.form = {};
                            $scope.post = function () {
                                $scope.result = "Adding New Entry..";
                                $http({
                                    method: 'POST',
                                    url: URL,
                                    params: $scope.form
                                }).then(function successCallback(response) {
                                    $scope.result = "Success : Last entry was added successfully..";
                                    $scope.form.id = response.data.id;
                                    $scope.list.push($scope.form);
                                    $scope.form = "";
                                }, function errorCallback(response) {
                                    $scope.result = "Error : Something Went Wrong..";
                                });
                            }// End of POST
                            $scope.get = function () {
                                $scope.getMessage = "Getting List...";
                                $http({
                                    method: 'GET',
                                    url: URL
                                }).then(function successCallback(response) {
                                    $scope.list = response.data;
                                    $scope.getMessage = "Successfully fetch list";
                                }, function errorCallback(response) {
                                    $scope.getMessage = "Error : Something went wrong while fetching list";
                                });
                            } //End of GET
                            $scope.put = function (index) {
                                var param = angular.toJson($scope.list.splice(index, 1));
                                console.log(param);
                                $http({
                                    method: 'PUT',
                                    url: URL,
                                    data: param,
                                    headers: {
                                        'Content-Type': 'application/json',
                                        'Accept': 'application/json'
                                    }
                                }).then(function successCallback(response) {
                                }, function errorCallback(response) {
                                });
                            }//End of PUT
                        }]);

        </script>


    </body>
</html>
