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
                <select class="form-control" ng-model="form.mainCategoryId">
                    <option ng-repeat="l in list" value="{{l.mainCategoryId}}">{{l.name}}</option>
                </select>
            </div><!--End of Select-->
            <div class="form-group">
                <label>First Sub Category Name</label>
                <input type="text" class="form-control" ng-model="form.first_Sub_Category_Name">
            </div><!--End of Text Field-->
            <button type="submit" class="btn btn-primary" ng-click="post();">Add Category</button>
            <br><br>
            <h4>Status : <b>{{result}}</b></h4>
            <br>
            <table class = "table table-bordered">
                <thead>
                    <tr>
                        <th>Sr.No</th>
                        <th>Name</th>
                        <th>Main Category Name</th>
                        <th>Update Action</th>
                        <th>Delete Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="l in firstSubCategory_List">
                        <td>{{($index + 1)}}</td>
                        <td>
                            <input type="text" value="{{l.name}}" ng-model="l.name" />
                        </td>   
                        <td>
                            <select class="form-control" ng-model="l.mainCategoryId" ng-init="sort(l);">
                                <option ng-repeat="l in list" value="{{l.mainCategoryId}}">{{l.name}}</option>
                            </select>
                        </td>
                        <td><input type="text" value="{{l.id}}" hidden=""><button ng-click="put(l);">Update</button></td></td>
                        <td><button ng-click="delete(l);">Delete</button></td>
                    </tr>
                </tbody>
            </table>

        </section>
        <script>
            app.controller("indexCtr", ["$scope", "$http", "MainCategory", "firstSubCategory", function ($scope, $http, MainCategory, firstSubCategory) {
                    $scope.form = new firstSubCategory();
                    $scope.sort=function (l){
                        //console.log(l);
                        l.mainCategoryId=l.mainCategoryId+"";
                    }
                    $scope.get = function () {
                        $scope.result = "Processing...";
                        $scope.list = MainCategory.query(function (res) {
                            $scope.result = "Success : fetching list";
                            console.log(res);
                            $scope.form.mainCategoryId = $scope.list[0].mainCategoryId + "";
                        }, function () {
                            $scope.result = "Error : fetching list";
                        });
                        $scope.firstSubCategory_List = firstSubCategory.query(function (response) {
                            $scope.result = "Success : fetching list";
                            console.log(angular.toJson(response));
                        }, function (response) {
                            $scope.result = "Error : fetching list";
                        });
                    }; //End of GET
                    $scope.post = function () {
                        $scope.result = "Processing...";
                        console.log($scope.form);
                        $scope.form.mainCategoryId = $scope.form.mainCategoryId + "";
                        $scope.form.$save(function (res) {
                            console.log(angular.toJson(res));
                            $scope.result = "Success : Last Entry was added successfully..";
                            $scope.firstSubCategory_List.push($scope.form);
                            $scope.form = new firstSubCategory();
                        }, function () {
                            $scope.result = "Error : Something Went wrong..";
                        });
                    }//End of POST

                    $scope.put = function (list) {
                        $scope.result = "Processing...";
                        list.mainCategoryId = list.mainCategoryId + "";
                        console.log("I/O : " + angular.toJson(list));
                        list.$update(function (res) {
                            $scope.result = "Success : Last entry was Updated Successfully..";
                            //$scope.getData(list);
                            console.log("O/P : " + angular.toJson(res));
                        }, function () {
                            $scope.result = "Error : Something went wrong while Updating last entry..";
                        });
                    }//End of PUT

                    $scope.delete = function (list) {
                        $scope.result = "Processing...";
                        list.$delete(function () {
                            $scope.result = "Success : Last Entry was deleted successfully..";
                            $scope.get();
                        }, function () {
                            $scope.result = "Error : Something Went wrong while deleting last entry..";
                        });
                    }

                }]);

        </script>


    </body>
</html>
