//列表控件
var tableIns;
var popForm;
layui.use(["form","table"], function(){
	  var layer = layui.layer;
	  var table = layui.table;
	  tableIns =table;
	  var form = layui.form;
	  popForm=layui.form;
	  table.render({
		    elem: '#indexTable'
		        ,url: appRootPath+'/blackWhiteInfo/infoList'
		        ,method: 'post'
		        ,request: {
		       	  	pageName: 'curr' //页码的参数名称，默认：page
		       		,limitName: 'limit' //每页数据量的参数名，默认：limit
		        	} 
		        ,page:true
		        ,id: 'indexTableReload'
		        ,limit: 10
		        ,limits:[10,15,20,50]//每页条数的选择项，默认：[10,20,30,40,50,60,70,80,90]。优先级低于 page 参数中的 limits 参数。
		        ,toolbar: '#toolbarIndex'
		        ,cols: [[
		          {field:'parkCode',align: 'left', title:'停车场编号'},
		          {field:'plateLicense',align: 'left', title:'车牌号码'},
		          {field:'tid',align: 'left', title:'tid'}
		        ]]
	  });
	  
	//搜索查询
	var $ = layui.$, active = {
		search: function(){
	      var parkCode = $('#parkCode').val();
	      var tid = $('#tid').val();
	      //执行重载
	      //indexTableReload为table 的id标识
	      table.reload('indexTableReload', {
	        page: {
	          curr: 1 //重新从第 1 页开始
	        }
	        ,where: {
	        	parkCode: parkCode
	            ,tid: tid
	        }
	      });
	    }
	};
	// 监听查询按钮
	 $('.indexSearch').on('click', function(){
		    var type = $(this).data('type');
		    active[type] ? active[type].call(this) : '';
		  });
	 
});


