<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="/import/header.jsp"%>
        <title>Add Main Category</title>
    </head>
    <body ng-app="popcon" ng-controller="indexCtr" ng-cloak="" ng-init="get();" class="container">
        <%@ include file="header.jsp"%>

        <section>

            <div class="form-group">
                <label>Main Category Name</label>
                <select class="form-control" ng-model="form.mainCategoryId" ng-change="sort(subList)">
                    <option ng-repeat="l in list" value="{{l.mainCategoryId}}">{{l.name}}</option>
                </select>
            </div><!--End of Select-->
            <div class="form-group">
                <label>First Sub Category Name</label>
                <select class="form-control" ng-model="form.firstSubcategoryId">
                    <option ng-repeat="l in subList|filter:form.mainCategoryId" value="{{l.firstSubcategoryId}}">{{l.name}}</option>
                </select>
            </div><!--End of Select-->            
            <div class="form-group">
                <label>Second Sub Category Name</label>
                <input type="text" class="form-control" ng-model="form.secondSubCategoryName">
            </div><!--End of Text Field-->
            <button type="submit" class="btn btn-primary" ng-click="post();">Add Category</button>
            <br><br>
            <h4>Status : <b>{{result}}</b></h4>
            <br>

            <table class = "table">
                <thead>
                    <tr>
                        <th>Sr.No</th>
                        <th>First Category Name</th>
                        <th>Main Category</th>
                        <th>First Sub Category</th>
                        <th>Update Action</th>
                        <th>Delete Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="l in thirdList">
                        <td>{{$index + 1}}</td>
                        <td><input type="text" value="{{l.name}}" ng-model="l.secondSubCategoryName"></td>
                        <td>
                            <select class="form-control" ng-model="l.mainCategoryId" ng-change="sort(subList)">
                                <option ng-repeat="l in list" value="{{l.mainCategoryId}}">{{l.name}}</option>
                            </select>
                        </td>
                        <td>
                            <select class="form-control" ng-model="l.firstSubcategoryId">
                                <option ng-repeat="l in subList|filter:l.mainCategoryId" value="{{l.firstSubcategoryId}}">{{l.name}}</option>
                            </select>
                        </td>
                        <td><button ng-click="put(l);">Update</button></td>
                        <td><button ng-click="delete(l);">Delete</button></td>
                    </tr>
                </tbody>

            </table>
        </section>
        <script>
                    app.controller("indexCtr", ["$scope", "$http", "MainCategory", "firstSubCategory", "secondSubCategory", "$timeout", function ($scope, $http, MainCategory, firstSubCategory, secondSubCategory, $timeout) {
                            $scope.form = new secondSubCategory();
                            $scope.sort = function (obj) {
                                var flag = true;
                                angular.forEach(obj, function (value) {
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
                                    //console.log($scope.subList);
                                    $scope.result = "Success : fetching list";
                                    $scope.form.firstSubcategoryId = $scope.subList[0].firstSubcategoryId + "";
                                    $timeout(function () {
                                        $scope.sort($scope.subList);
                                    }, 200);
                                }, function (response) {
                                    $scope.result = "Error : fetching list";
                                });

                                $scope.getSecondSubCategoryList();

                            }; //End of GET

                            $scope.getSecondSubCategoryList = function () {
                                $scope.result = "Refreshing List..";
                                $scope.thirdList = secondSubCategory.query(function (response) {
                                    console.log(angular.toJson($scope.thirdList));
                                    $scope.result = "Success : fetching list";
                                }, function () {
                                    $scope.result = "Error : fetching list";
                                });
                            }

                            $scope.post = function () {
                                $scope.result = "Processing...";
                                console.log($scope.form);
                                $scope.form.$save(function (res) {
                                    $scope.result = "Success : Last Entry was added successfully..";
                                    $scope.thirdList.push(res);
                                    console.log(angular.toJson(res));
                                }, function (res) {
                                    $scope.result = "Error : Something Went wrong..";
                                    console.log("Error:..");
                                });
                            } //End of POST
                            $scope.delete = function (obj) {
                                $scope.result = "Processing...";
                                obj.$delete(function (succ) {
                                    $scope.result = "Last Entry was Deleted Successfully...";
                                    $scope.getSecondSubCategoryList();
                                }, function (err) {
                                    $scope.result = "Error while Deleteing Last Entry...";
                                });
                            }//End of DELETE
                            $scope.put = function (obj) {
                                $scope.result = "Processing...";
                                obj.$update(function (succ) {
                                    $scope.result = "Last Entry was Updated Successfully...";
                                }, function (err) {
                                    $scope.result = "Error while Updateing Last Entry...";
                                });
                            }//End of UPDATE

                        }]);

        </script>


    </body>
</html>
