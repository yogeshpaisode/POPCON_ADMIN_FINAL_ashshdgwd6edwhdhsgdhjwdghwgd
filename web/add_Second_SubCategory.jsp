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
                <select class="form-control" ng-model="form.main_Category_id">
                    <option ng-repeat="l in list" value="{{l.id}}">{{l.name}}</option>
                </select>
            </div><!--End of Select-->
            <div class="form-group">
                <label>First Sub Category Name</label>
                <select class="form-control" ng-model="form.first_Sub_Category_id">
                    <option ng-repeat="l in subList |filter:form.main_Category_id" value="{{l.id}}">{{l.name}}</option>
                </select>
            </div><!--End of Select-->
            <h4>Status : <b>{{result}}</b></h4>
            <br>
        </section>
        <script>
                    app.controller("indexCtr", ["$scope", "$http", "MainCategory", "firstSubCategory", function ($scope, $http, MainCategory, firstSubCategory) {
                            $scope.form = new firstSubCategory();
                            
                            $scope.get = function () {
                                $scope.result = "Processing...";
                                $scope.list = MainCategory.query(function () {
                                    $scope.result = "Success : fetching list";
                                    $scope.form.main_Category_id = $scope.list[0].id + "";
                                }, function () {
                                    $scope.result = "Error : fetching list";
                                });
                                $scope.subList = firstSubCategory.query(function (response) {
                                    $scope.result = "Success : fetching list";
                                    $scope.form.first_Sub_Category_id = $scope.subList[0].id + "";
                                }, function (response) {
                                    $scope.result = "Error : fetching list";
                                });
                            }; //End of GET
                        }]);

        </script>


    </body>
</html>
