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
        <%@ include file="header.jsp"%>

        <section>

            <div class="form-group">
                <label>Main Category Name</label>
                <select class="form-control" ng-model="mainForm.mainCategoryId">
                    <option ng-repeat="l in mainList" value="{{l.mainCategoryId}}">{{l.name}}</option>
                </select>
            </div><!--End of Select-->
            <div class="form-group">
                <label>First Sub Category Name</label>
                <select class="form-control" ng-model="mainForm.firstSubcategoryId">
                    <option ng-repeat="l in firstSubList|filter:mainForm.mainCategoryId" value="{{l.firstSubcategoryId}}">{{l.name}}</option>
                </select>
            </div><!--End of Select-->    
            <div class="form-group">
                <label>Second Sub Category Name</label>
                <select class="form-control" ng-model="mainForm.secondSubcategoryId">
                    <option ng-repeat="l in secondSubList|filter:mainForm.firstSubcategoryId" value="{{l.secondSubcategoryId}}">{{l.secondSubCategoryName}}</option>
                </select>
            </div><!--End of Select-->    
            <div class="form-group">
                <label>Search Text</label>
                <textarea class="form-control" ng-model="mainForm.searchTag"></textarea>
            </div><!--End of Select-->    
            <div class="form-group">
                <label>Product Detail</label>
                <textarea class="form-control" ng-model="mainForm.productDetail"></textarea>
            </div><!--End of Select-->    
            <div class="form-group">
                <label>Material Detail</label>
                <textarea class="form-control" ng-model="mainForm.materialDetail"></textarea>
            </div><!--End of Select-->    
            <div class="form-group">
                <label>Care</label>
                <textarea class="form-control" ng-model="mainForm.care"></textarea>
            </div><!--End of Select-->
            <div class="form-group">
                <label>Selling Price:</label>
                <textarea class="form-control" ng-model="mainForm.sellingPrice"></textarea>
            </div><!--End of Select-->
            <div class="form-group">
                <label>% Off:</label>
                <textarea class="form-control" ng-model="mainForm.off"></textarea>
            </div><!--End of Select-->
            <div class="form-group">
                <label>Display Price:</label>
                <textarea class="form-control" ng-model="mainForm.displayPrice"></textarea>
            </div><!--End of Select-->
        </section>

        <hr>


        <div>
            Color: <input type="text" value="" ng-model="form.color"/>
            <br>
            Hex: <input type="text" value="" ng-model="form.hex"/>
            <br>
            Title: <input type="text" value="" ng-model="form.title"/>
            <br>

            <table class = "table">
                <thead>
                    <tr>
                        <th>Sr.No.</th>
                        <th>Image</th>
                        <th>Uploading Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="img in form.images">
                        <td>{{$index+1}}</td>
                        <td><img src="{{img.path}}" style="width: 100px;height:100px;"/></td>
                        <td>{{img.uploadStatus}}</td>
                        <td><button ng-click="deleteImg($index, form.images);">Delete</button></td>
                    </tr>
                </tbody>
            </table>
            <br>
            <input type="file" file-model="myFile" multiple="" id="file"/>
            <button ng-click="addImg(form);">Add Img</button>
            <br><br>
            <button ng-click="add();">Add</button>
            <hr>
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
                            $scope.mainForm =
                                    {
                                        "color": $scope.colorList,
                                        "sizeList": $scope.size
                                    };

                            $scope.get = function () {
                                $scope.mainList = MainCategory.query(function () {
                                    $scope.result = "Success : fetching list";
                                    $scope.mainForm.mainCategoryId = $scope.mainList[0].mainCategoryId + "";
                                }, function () {
                                    $scope.result = "Error : fetching list";
                                });
                                $scope.firstSubList = firstSubCategory.query(function (response) {
                                    //console.log($scope.subList);
                                    $scope.result = "Success : fetching list";
                                    $scope.mainForm.firstSubcategoryId = $scope.firstSubList[0].firstSubcategoryId + "";
                                }, function (response) {
                                    $scope.result = "Error : fetching list";
                                });

                                $scope.secondSubList = secondSubCategory.query(function (response) {
                                    console.log(angular.toJson($scope.secondSubList) + "Second");
                                    $scope.result = "Success : fetching list";
                                    $scope.mainForm.secondSubcategoryId = $scope.secondSubList[0].secondSubcategoryId + "";
                                }, function (response) {
                                    $scope.result = "Error : fetching list";
                                });

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
                        }]);
        </script>


    </body>
</html>
