/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.in.popcon.test;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author yogeshpaisode
 */
public class Stock {

    public static void main(String[] args) throws JSONException {
        String json = "{\"color\":[{\"images\":[{\"name\":\"Screen Shot 2016-06-12 at 11.16.01 AM.png\",\"uploadStatus\":\"Uploaded Successfully...1\",\"path\":\"http://upchar.esy.es/img/Screen Shot 2016-06-12 at 11.16.01 AM.png\"},{\"name\":\"Screen Shot 2016-06-12 at 11.16.10 AM.png\",\"uploadStatus\":\"Uploaded Successfully...2\",\"path\":\"http://upchar.esy.es/img/Screen Shot 2016-06-12 at 11.16.10 AM.png\"}],\"color\":\"Red\",\"hex\":\"#rere\",\"title\":\"this is title\"},{\"images\":[{\"name\":\"Screen Shot 2016-06-12 at 11.16.16 AM.png\",\"uploadStatus\":\"Uploaded Successfully...1\",\"path\":\"http://upchar.esy.es/img/Screen Shot 2016-06-12 at 11.16.16 AM.png\"},{\"name\":\"Screen Shot 2016-06-12 at 11.16.22 AM.png\",\"uploadStatus\":\"Uploaded Successfully...0\",\"path\":\"http://upchar.esy.es/img/Screen Shot 2016-06-12 at 11.16.22 AM.png\"}],\"color\":\"Yellow\",\"hex\":\"#terst\",\"title\":\"this is title\"}],\"sizeList\":[{\"type\":\"Small\",\"stock\":[{\"color\":\"Red\",\"count\":\"32\"},{\"color\":\"Yellow\",\"count\":\"43\"}],\"isSelected\":true},{\"type\":\"Medium\",\"stock\":[{\"color\":\"Red\",\"count\":\"43\"},{\"color\":\"Yellow\",\"count\":\"43\"}],\"isSelected\":true},{\"type\":\"Large\",\"stock\":[{\"color\":\"Red\",\"count\":\"54\"},{\"color\":\"Yellow\",\"count\":\"65\"}],\"isSelected\":true}],\"firstSubcategoryId\":\"36\",\"mainCategoryId\":\"19\",\"secondSubcategoryId\":\"11\",\"searchTag\":\"#search Search#Search\",\"productDetail\":\"product detail text\",\"materialDetail\":\"material detail text\",\"care\":\"care detail test\",\"sellingPrice\":\"300\",\"off\":\"20\",\"displayPrice\":\"330\"}";
        JSONObject jSONObject = new JSONObject(json);
        JSONArray sizeArray = jSONObject.getJSONArray("sizeList");

        JSONObject sizeObj = sizeArray.getJSONObject(0);
        
        System.out.println(sizeObj.getJSONArray("stock"));
        
        
    }
}
