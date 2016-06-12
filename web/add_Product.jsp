<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <%@ include file="/import/header.jsp"%>
    </head>
    <body ng-app="popcon" ng-controller="indexCtr" ng-cloak="" ng-init="get();" class="container">

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
         </section>
        
        <hr>
        
        
        <div>
            Color: <input type="text" value="" ng-model="form.color"/>
            <br>
            Hex: <input type="text" value="" ng-model="form.hex"/>
            <br>
            <div ng-repeat="img in form.images">
                <img src="{{img.path}}" style="width: 50px;height: 50px;"/>{{img.uploadStatus}}....<button ng-click="deleteImg($index, form.images);">Delete</button>
            </div>
            <br>
            <input type="file" file-model="myFile" multiple="" id="file"/>
            <button ng-click="addImg(form);">Add Img</button>
            <br><br>
            <button ng-click="add();">Add</button>
        </div>
        <br><br>

        <div ng-repeat="f in colorList">
            Color: <input type="text" value="{{f.color}}" ng-model="f.color"/>
            <br>
            Hex: <input type="text" value="{{f.hex}}" ng-model="f.hex"/>
            <br>
            <div ng-repeat="img in f.images">
                <img src="{{img.path}}" style="width: 50px;height: 50px;"/>..<button ng-click="deleteImg($index, f.images);">Delete</button>
            </div>
            <br>
            <button ng-click="triggerFileBox();">select File</button>
            <button ng-click="addImg(f);">Add Img</button>
            <hr>
        </div>

        <div ng-repeat="s in size">
            {{s.type}}..<input type="checkbox" ng-model="s.isSelected"><br>
            <div ng-repeat="f in colorList" ng-if="s.isSelected">
                {{s.stock[$index].color = f.color}}
                <img src="{{f.images[0].path}}" style="width: 50px;height: 50px;"/>..<input type="text" ng-model="s.stock[$index].count">
            </div>
        </div>


        <button ng-click="pushAll();">Push all</button>
        {{mainForm}}
        <script>
                            app.directive('fileModel', ['$parse', function ($parse) {
                                    return {
                                        restrict: 'A',
                                        link: function (scope, element, attrs) {
                                            var model = $parse(attrs.fileModel);
                                            var modelSetter = model.assign;

                                            element.bind('change', function () {
                                                scope.$apply(function () {
                                                    modelSetter(scope, element[0].files[0]);
                                                });
                                            });
                                        }
                                    };
                                }])
                            app.controller("indexCtr", ["$scope", "$http", "MainCategory", "firstSubCategory", "secondSubCategory", function ($scope, $http, MainCategory, firstSubCategory, secondSubCategory) {
                                    var url = "http://upchar.esy.es/img/";

                                    $scope.colorList = [];
                                    $scope.size = [{type: "Small", stock: [], isSelected: false}, {type: "Medium", stock: [], isSelected: false}, {type: "Large", stock: [], isSelected: false}];
                                    $scope.form = {images: []};
                                    var imgIndex = 0;

                                    $scope.get=function (){
                                        
                                    }

                                    $scope.add = function () {
                                        $scope.colorList.push($scope.form);
                                        $scope.form = {images: []};
                                        imgIndex = 0;
                                    }
                                    $scope.addImg = function (formObj) {
                                        imgIndex++;
                                        var obj = {name: $scope.myFile.name, uploadStatus: "Preparing..", path: ""};
                                        var fileObj = $scope.myFile;
                                        formObj.images.push(obj);
                                        uploadFile(obj, fileObj);
                                    }
                                    var uploadFile = function (obj, fileObj) {
                                        obj.uploadStatus = "Uploading..." + imgIndex;
                                        var fd = new FormData();
                                        fd.append('image', fileObj);

                                        $http({
                                            method: 'POST',
                                            url: "http://upchar.esy.es/upload.php",
                                            headers: {'Content-Type': undefined},
                                            data: fd
                                        }).then(function successCallback(response) {
                                            obj.uploadStatus = "Uploaded Successfully..." + imgIndex;
                                            obj.path = url + obj.name;
                                        }, function errorCallback(response) {
                                            obj.uploadStatus = "Error while Uploading..." + imgIndex;
                                        });
                                    }

                                    $scope.deleteImg = function (index, list) {
                                        list.splice(index, 1);
                                    }

                                    $scope.triggerFileBox = function () {
                                        $("#file").click();
                                    }
                                    $scope.pushAll = function () {
                                        $scope.mainForm = [{"color": $scope.colorList}, {"sizeList": $scope.size}];
                                    }
                                }]);
        </script>


    </body>
</html>
