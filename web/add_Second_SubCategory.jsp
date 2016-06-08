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
                <label>Main Category Name</label>
                <select class="form-control" ng-model="form.mainCategoryId" ng-change="sort()">
                    <option ng-repeat="l in list" value="{{l.mainCategoryId}}">{{l.name}}</option>
                </select>
            </div><!--End of Select-->
            <div class="form-group">
                <label>First Sub Category Name</label>
                <select class="form-control" ng-model="form.firstSubcategoryId">
                    <option ng-repeat="l in subList|filter:form.mainCategoryId" value="{{l.firstSubcategoryId}}">{{l.name}}</option>
                </select>
            </div><!--End of Select-->
            <h4>Status : <b>{{result}}</b></h4>
            <br>
        </section>
        <script>
                    app.controller("indexCtr", ["$scope", "$http", "MainCategory", "firstSubCategory","$timeout",function ($scope, $http, MainCategory, firstSubCategory,$timeout) {
                            $scope.form = new firstSubCategory();
                            $scope.sort = function () {
                                var flag = true;
                                angular.forEach($scope.subList, function (value) {
                                    if ((value.mainCategoryId == $scope.form.mainCategoryId) && flag) {
                                        $scope.form.firstSubcategoryId = value.firstSubcategoryId + "";
                                        flag = false;
                                    }
                                }, "");
                            }
                            $scope.get = function () {
                                $scope.result = "Processing...";
                                $scope.list = MainCategory.query(function () {
                                    $scope.result = "Success : fetching list";
                                    $scope.form.mainCategoryId = $scope.list[0].mainCategoryId + "";
                                }, function () {
                                    $scope.result = "Error : fetching list";
                                });
                                $scope.subList = firstSubCategory.query(function (response) {
                                    console.log($scope.subList);
                                    $scope.result = "Success : fetching list";
                                    $scope.form.firstSubcategoryId = $scope.subList[0].firstSubcategoryId + "";
                                    $timeout(function () {
                                        $scope.sort();
                                    }, 200);
                                }, function (response) {
                                    $scope.result = "Error : fetching list";
                                });
                            }; //End of GET
                        }]);

        </script>


    </body>
</html>
