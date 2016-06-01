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
                            <select class="form-control" ng-model="l.mainCategoryId" ng-change="getData(l.mainCategoryId);" >
                                <option ng-repeat="l in list" value="{{l.id}}">{{l.name}}</option>
                            </select>
                            <p ng-bind="getData(l.mainCategoryId);"></p>
                        </td>
                        <td><input type="text" value="{{l.id}}" hidden=""><button ng-click="put(l);">Update</button></td></td>
                        <td><button ng-click="delete(l, $index);">Delete</button></td>
                    </tr>
                </tbody>
            </table>

        </section>
        <script>
            app.controller("indexCtr", ["$scope", "$http", "MainCategory", "firstSubCategory", function ($scope, $http, MainCategory, firstSubCategory) {
                    $scope.form = new firstSubCategory();
                    $scope.getData=function (id){
                        var re_id=id+"";
                        var cat_name="bla";
                        for(var i=0;i<$scope.list.length;i++){
                            var loc_id=$scope.list[i].id+"";
                            if(loc_id==re_id){
                                cat_name=$scope.list[i].name;
                                break;
                            }
                        }
                        return cat_name;
                    }
                    $scope.get = function () {
                        $scope.result = "Processing...";
                        $scope.list = MainCategory.query(function () {
                            $scope.result = "Success : fetching list";
                            $scope.form.main_Category_id = $scope.list[0].id + "";
                        }, function () {
                            $scope.result = "Error : fetching list";
                        });
                        $scope.firstSubCategory_List = firstSubCategory.query(function (response) {
                            $scope.result = "Success : fetching list";
                            //console.log(angular.toJson(response));
                        }, function (response) {
                            $scope.result = "Error : fetching list";
                        });
                    }; //End of GET
                    $scope.post = function () {
                        $scope.result = "Processing...";
                        $scope.form.$save(function (res) {
                            console.log(angular.toJson(res));
                            $scope.result = "Success : Last Entry was added successfully..";
                            $scope.firstSubCategory_List.push($scope.form);
                            $scope.form = new firstSubCategory();
                        }, function () {
                            $scope.result = "Error : Something Went wrong..";
                        });
                    }//End of POST
                    
                    $scope.put=function (list){
                        list.mainCategoryId=list.mainCategoryId+"";
                        console.log(list);
                    }//End of PUT
                    
                }]);

        </script>


    </body>
</html>
